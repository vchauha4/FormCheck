import numpy as np
import cv2

max_left = 0
max_right = 0
lowest_wrist_distance = 120
imbalancefound = False

# Recomendation code max angles squat
imbalancefoundsquat = False
lowest_feet_distance = 120
min_depth = 40

#Recommendations for squat improvement
def squat_recs(image, keypoints,advice):

    global min_depth
    global lowest_feet_distance
    global imbalancefoundsquat

    # CALCULATE LEFT SHOULDER ANGLE
    left_knee_angle = calculate_angle(
        keypoints[11], keypoints[13], keypoints[15])
    # CALCULATE RIGHT SHOULDER ANGLE
    right_knee_angle = calculate_angle(
        keypoints[12], keypoints[14], keypoints[16])

    confidence_factor = (keypoints[14][2] + keypoints[13][2]) / 2

    # Recomendation 1 -- Imbalance in knees
    # Found based on difference between left and right angle past a certain threshold (in this case 45)
    # print(abs(left_knee_angle-right_knee_angle))
    if (abs(left_knee_angle-right_knee_angle) >= 35 and confidence_factor > 0.5):
        img_num = 1
        advice.append(("Angle imbalance detected", str(
            left_knee_angle), str(right_knee_angle)))
        # print("RECCOMENDATION: You're knee's are imbalanced, try to re-center yourself or lower you're weight to go down equally")
        # This is to prevent over-writes but also can use just reg string
        cv2.imwrite("imbalance_squat{}.jpg".format(img_num), image)
        imbalancefoundsquat = True
        img_num += 1

    # Recomendation 2 -- Feet too close
        # Found based on difference between two feet
    # distance_of_feet = abs(keypoints[16][1] - keypoints[15][1])

    # Recomendation 3 -- Squat Depth
        # CALCULATE RIGHT HIP - RIGHT ANKLE
    distance_of_body = abs(keypoints[12][1] - keypoints[16][1])

    if distance_of_body < min_depth:
        img_numv2 = 1
        cv2.imwrite("lowest_depth{}.jpg".format(img_numv2), image)
        min_depth = distance_of_body
        img_numv2 += 1
        # print(distance_of_wrists, " ", lowest_wrist_distance)

#Recemmendation for bench press improvements
def bench_recs(image, keypoints,advice):

    global max_left
    global max_right
    global imbalancefound
    global lowest_wrist_distance

    # CALCULATE LEFT SHOULDER ANGLE
    left_shoulder_angle = calculate_angle(
        keypoints[9], keypoints[7], keypoints[5])
    # CALCULATE RIGHT SHOULDER ANGLE
    right_shoulder_angle = calculate_angle(
        keypoints[10], keypoints[8], keypoints[6])

    # Recomendation 1 -- Imbalance in lifting each arm
    # Found based on difference between left and right angle past a certain threshold (in this case 45)
    if (abs(left_shoulder_angle-right_shoulder_angle) >= 45):
        img_num = 1
        advice.append(("Angle imbalance detected: " +
                      str(left_shoulder_angle) + " " + str(right_shoulder_angle)))
        advice.append(
            ("RECCOMENDATION: Try lowering the weight as you're form is showing an imbalance"))
        # This is to prevent over-writes but also can use just reg string
        cv2.imwrite("imbalance_bench{}.jpg".format(img_num), image)
        imbalancefound = True
        img_num += 1

    # Recomendation 2 -- Not going all the way up
        # Found based on the max angle during the entire rep
    if left_shoulder_angle > max_left:
        max_left = left_shoulder_angle
    if right_shoulder_angle > max_right:
        max_right = right_shoulder_angle

    # Recomendation 3 -- Wrist distance
    # CALCULATE RIGHT WRIST - LEFT RIST DISTANCE
    distance_of_wrists = abs(keypoints[10][0] - keypoints[9][0])

    if distance_of_wrists < lowest_wrist_distance:
        img_numv2 = 1
        cv2.imwrite("wrist{}.jpg".format(img_numv2), image)
        lowest_wrist_distance = distance_of_wrists
        img_numv2 += 1
        # print(distance_of_wrists, " ", lowest_wrist_distance)

#General recommendations
def check_reccs(choice,advice):

    # BENCH
    if choice == 0:
        global max_left
        global max_right
        global imbalancefound
        global lowest_wrist_distance

        if (max_right < 150 or max_left < 150):
            advice.append(("RECCOMENDATION: You need to lift the bar all the way up -- Try lower the weight as your max angles were: " +
                          str(max_left) + " , " + str(max_right)))
            # print
        else:
            advice.append(("OBSERVATION: You're lifting the bar all the way to the top! Good job! " +
                          str(max_right) + " , " + str(max_right)))

        if (imbalancefound == False):
            advice.append(("OBSERVATION: No imbalance in arms found"))

        if (lowest_wrist_distance < 120):
            advice.append(
                ("RECCOMENDATION: Try to move you're arms further apart - They might be too close together"))
    # SQUAT
    elif choice == 1:

        global min_depth
        global imbalancefoundsquat
        global lowest_feet_distance

        if (imbalancefoundsquat == False):
            advice.append(("OBSERVATION: No imbalance in knees found"))

        if (min_depth > 25):
            advice.append(("RECCOMENDATION: You're likely not going deep enough. Try to go deeper with you're squat to maximize tension. This may require a lower weight. Lowest Depth Recorded: " + str(min_depth)))
        else:
            advice.append(
                ("OBSERVATION: You are going to optimal depth with you're squats! Lowest Depth Recorded: " + str(min_depth)))

#Calculates angles
def calculate_angle(p1, p2, p3):
    radians = np.arctan2(p3[1] - p2[1], p3[0] - p2[0]) - np.arctan2(p1[1] - p2[1], p1[0] - p2[0])
    joint_angle = np.abs(radians * 180.0 / np.pi)

    if joint_angle > 180.0:
        joint_angle = 360 - joint_angle

    return joint_angle