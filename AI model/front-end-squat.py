#Imports
import cv2
import numpy as np
from scipy import signal
import matplotlib.pyplot as plt
import pandas as pd
import tensorflow as tf
from sklearn.metrics import accuracy_score
from sklearn.metrics import mean_absolute_error
import joblib

#######---------MOVENET CODE START--------------#########


# TFLite interpreter
num_kps = 17
input_size = 256

interpreter = tf.lite.Interpreter(model_path="thunder_model.tflite")
interpreter.allocate_tensors()

#Reccomendation code max angles bench
max_left = 0
max_right = 0
lowest_wrist_distance = 120
imbalancefound = False

#Reccomendation code max angles squat
imbalancefoundsquat = False
lowest_feet_distance = 120
min_depth = 40

switch = 0
dataAngles = [[[],[]],[[],[]]]
angles = []
counter  =0
COLORS= {
    'm': (62, 74, 179),
    'c': (3, 4, 5),
    'y': (92, 13, 30),
}

EDGE_TO_COLOR = {
    (0, 1): COLORS['m'],
    (0, 2): COLORS['c'],
    (1, 3): COLORS['m'],
    (2, 4): COLORS['c'],
    (0, 5): COLORS['m'],
    (0, 6): COLORS['c'],
    (5, 7): COLORS['m'],
    (7, 9): COLORS['m'],
    (6, 8): COLORS['c'],
    (8, 10): COLORS['c'],
    (5, 6): COLORS['y'],
    (5, 11): COLORS['m'],
    (6, 12): COLORS['c'],
    (11, 12): COLORS['y'],
    (11, 13): COLORS['m'],
    (13, 15): COLORS['m'],
    (12, 14): COLORS['c'],
    (14, 16): COLORS['c'],
}
def calculate_angle(p1, p2, p3):
    radians = np.arctan2(p3[1] - p2[1], p3[0] - p2[0]) - np.arctan2(p1[1] - p2[1], p1[0] - p2[0])
    joint_angle = np.abs(radians * 180.0 / np.pi)

    if joint_angle > 180.0:
        joint_angle = 360 - joint_angle

    return joint_angle


# Computes if the given joints are horizontal according to the y axis position, within a given error.
def horizontal_joints(joints_y, y_axis, error):
    for y in joints_y:
        if not(y_axis - error <= y <= y_axis + error):
            return False
    return True


# Computes if the given joints are vertical according to the x axis position, within a given error.
def vertical_joints(joints_x, x_axis, error):
    for x in joints_x:
        if not(x_axis - error <= x <= x_axis + error):
            return False
    return True


def joint_in_region(x, y, x_axis, y_axis, x_error, y_error):
    return x_axis - x_error <= x <= x_axis + x_error and y_axis - y_error <= y <= y_axis + y_error


def angle_in_region(angle, expected_radius, radius_error):
    return expected_radius - radius_error <= angle <= expected_radius + radius_error


# Draws the angle on the reference joint.
def visualize_angle(frame, pos, angle):
    cv2.putText(
        img=frame,
        text=str(angle),
        org=pos,
        fontFace=cv2.FONT_HERSHEY_SIMPLEX,
        fontScale=2.0,
        color=(0, 255, 0),
        thickness=2,
        lineType=cv2.LINE_AA
    )

# # Computes the pose similarity of 2 different poses, using the Mean Absolute Error Method.
# def compute_pose_similarity(self, joints1, joints2):
#     if len(joints2) == len(self._exercise_joints):
#         mae = 0
#     #     for j in self._exercise_joints:# NEED TO CHANGE THIS
#     #         mae += abs(np.linalg.norm(np.array(joints1[j]) - np.array(joints2[j])))
#     #     return mae
#     # else:
#     #     return 10000


def movenet(input_image):
    """Runs detection on an input image.
    Args:
      input_image: A [1, height, width, 3] tensor represents the input image
        pixels. Note that the height/width should already be resized and match the
        expected input resolution of the model before passing into this function.
    Returns:
      A [1, 1, 17, 3] float numpy array representing the predicted keypoint
      coordinates and scores.
    """
    # TF Lite format expects tensor type of uint8.
    input_image = tf.cast(input_image, dtype=tf.uint8)
    input_details = interpreter.get_input_details()
    output_details = interpreter.get_output_details()

    interpreter.set_tensor(input_details[0]['index'], input_image.numpy())
    interpreter.invoke() # Invoke inference.

    # Get the model prediction.
    keypoints_with_scores = interpreter.get_tensor(output_details[0]['index'])
    
    
    dataAngles[1][switch].append(calculate_angle(keypoints_with_scores[0][0][16], keypoints_with_scores[0][0][14], keypoints_with_scores[0][0][12])+calculate_angle(keypoints_with_scores[0][0][15], keypoints_with_scores[0][0][13], keypoints_with_scores[0][0][11]))
    angles.append(calculate_angle(keypoints_with_scores[0][0][15], keypoints_with_scores[0][0][13], keypoints_with_scores[0][0][11])+calculate_angle(keypoints_with_scores[0][0][16], keypoints_with_scores[0][0][14], keypoints_with_scores[0][0][12]))
    #dataAngles[0][switch].append(keypoints_with_scores[0][0][9][1])
    

    #else:
    #    print(keypoints_with_scores[0][0][9][2]+"*******************")
    #print(keypoints_with_scores[0][0][5])
    #print(keypoints_with_scores[0][0][7])
    #print(keypoints_with_scores[0][0][9])

    #print(calculate_angle(keypoints_with_scores[0][0][5], keypoints_with_scores[0][0][7], keypoints_with_scores[0][0][9]))
    #print(dataAngles)

    return keypoints_with_scores

def pad(image, width, height):
    image_width = image.shape[1]
    image_height = image.shape[0]

    # get resize ratio
    resize_ratio = min(width / image_width, height / image_height)

    # compute new height and width
    new_width = int(resize_ratio * image_width)
    new_height = int(resize_ratio * image_height)
    new_img = cv2.resize(image, (new_width, new_height))

    # compute padded height and width
    pad_width = (width - new_width) // 2
    pad_height = (height - new_height) // 2

    padded_image = cv2.copyMakeBorder(new_img,
                                      pad_height,
                                      pad_height,
                                      pad_width,
                                      pad_width,
                                      cv2.BORDER_REPLICATE,
                                      value=0)

    return cv2.resize(padded_image, (input_size, input_size))



def get_inference(image):
    # Resize and pad the image to keep the aspect ratio and fit the expected size.
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image = pad(image, input_size, input_size)
    image = cv2.resize(image, (input_size, input_size))
    input_image = image

    input_image = np.expand_dims(input_image, axis=0)

    # Run model inference.
    kps = movenet(input_image)[0]
    

    return kps[0], image



def preprocess_kps(kps, height, width):
    for i in range(len(kps)):
        temp = kps[i][1]
        kps[i][1] = kps[i][0] * height
        kps[i][0] = temp * width
    return kps

def draw_pose(image, keypoints, radius=2):
    height, width, channel = image.shape
    kps = preprocess_kps(keypoints, height, width)
    for c in kps:
        x, y, s = c
        if s > 0.2:
            cv2.circle(image,
                       (int(x), int(y)),
                       radius, (41, 128, 185), -1)
    for edge_pair, color in EDGE_TO_COLOR.items():
        start, end = edge_pair
        x1, y1, s1 = kps[start]
        x2, y2, s2 = kps[end]
        cv2.line(image,
                 (int(x1), int(y1)),
                 (int(x2), int(y2)),
                 color, 1,
                 lineType=cv2.LINE_AA)
    return image

def bench_recs(image, keypoints):

    global max_left
    global max_right
    global imbalancefound
    global lowest_wrist_distance

    #CALCULATE LEFT SHOULDER ANGLE
    left_shoulder_angle = calculate_angle(keypoints[9],keypoints[7],keypoints[5])
    #CALCULATE RIGHT SHOULDER ANGLE
    right_shoulder_angle = calculate_angle(keypoints[10],keypoints[8],keypoints[6])

    

    #Recomendation 1 -- Imbalance in lifting each arm 
        #Found based on difference between left and right angle past a certain threshold (in this case 45)
    if(abs(left_shoulder_angle-right_shoulder_angle) >= 45):
        img_num = 1
        print("Angle imbalance detected",left_shoulder_angle,right_shoulder_angle)
        print("RECCOMENDATION: Try lowering the weight as you're form is showing an imbalance")
        cv2.imwrite("imbalance_bench{}.jpg".format(img_num),image) #This is to prevent over-writes but also can use just reg string
        imbalancefound = True
        img_num += 1

    #Recomendation 2 -- Not going all the way up
        #Found based on the max angle during the entire rep
    if left_shoulder_angle > max_left:
        max_left = left_shoulder_angle
    if right_shoulder_angle > max_right:
        max_right = right_shoulder_angle
    
    #Recomendation 3 -- Wrist distance
    #CALCULATE RIGHT WRIST - LEFT RIST DISTANCE
    distance_of_wrists = abs(keypoints[10][0] - keypoints[9][0])

    if distance_of_wrists < lowest_wrist_distance:
        img_numv2 = 1
        cv2.imwrite("wrist{}.jpg".format(img_numv2),image)
        lowest_wrist_distance = distance_of_wrists
        img_numv2 += 1
        #print(distance_of_wrists, " ", lowest_wrist_distance)

def squat_recs(image, keypoints):

    global min_depth
    global lowest_feet_distance
    global imbalancefoundsquat

    #CALCULATE LEFT SHOULDER ANGLE
    left_knee_angle = calculate_angle(keypoints[11],keypoints[13],keypoints[15])
    #CALCULATE RIGHT SHOULDER ANGLE
    right_knee_angle = calculate_angle(keypoints[12],keypoints[14],keypoints[16])

    confidence_factor =  (keypoints[14][2] + keypoints[13][2]) / 2

    #Recomendation 1 -- Imbalance in knees
        #Found based on difference between left and right angle past a certain threshold (in this case 45)
    #print(abs(left_knee_angle-right_knee_angle))    
    if(abs(left_knee_angle-right_knee_angle) >= 35 and confidence_factor > 0.5):
        img_num = 1
        print("Angle imbalance detected",left_knee_angle,right_knee_angle)
        #print("RECCOMENDATION: You're knee's are imbalanced, try to re-center yourself or lower you're weight to go down equally")
        cv2.imwrite("imbalance_squat{}.jpg".format(img_num),image) #This is to prevent over-writes but also can use just reg string
        imbalancefoundsquat = True
        img_num += 1
    
    
    #Recomendation 2 -- Feet too close
        #Found based on difference between two feet
    #distance_of_feet = abs(keypoints[16][1] - keypoints[15][1])
    
    
    #Recomendation 3 -- Squat Depth
        #CALCULATE RIGHT HIP - RIGHT ANKLE
    distance_of_body = abs(keypoints[12][1] - keypoints[16][1])
    
    if distance_of_body < min_depth:
        img_numv2 = 1
        cv2.imwrite("lowest_depth{}.jpg".format(img_numv2),image)
        min_depth = distance_of_body
        img_numv2 += 1
        #print(distance_of_wrists, " ", lowest_wrist_distance)
    
    

def check_reccs():
    global choice

    #BENCH
    if choice == 0:
        global max_left
        global max_right
        global imbalancefound
        global lowest_wrist_distance

        if(max_right < 150 or max_left < 150):
            print("RECCOMENDATION: You need to lift the bar all the way up -- Try lower the weight as your max angles were: ", max_left, max_right)
        else:
            print("OBSERVATION: You're lifting the bar all the way to the top! Good job!",max_right,max_right)

        if(imbalancefound == False):
            print("OBSERVATION: No imbalance in arms found")
        
        if(lowest_wrist_distance < 120):
            print("RECCOMENDATION: Try to move you're arms further apart - They might be too close together")
    #SQUAT
    elif choice == 1:
        
        global min_depth
        global imbalancefoundsquat
        global lowest_feet_distance

        if(imbalancefoundsquat == False):
            print("OBSERVATION: No imbalance in knees found")
        
        if(min_depth > 25):
            print("RECCOMENDATION: You're likely not going deep enough. Try to go deeper with you're squat to maximize tension. This may require a lower weight. Lowest Depth Recorded: " + str(min_depth))
        else:
            print("OBSERVATION: You are going to optimal depth with you're squats! Lowest Depth Recorded: " + str(min_depth))


def main(vidPath):

    cap = cv2.VideoCapture(vidPath)
    fname = 'op_' + str(vidPath.split("/")[-1])

    fps = cap.get(cv2.CAP_PROP_FPS)  # 25

    ## Writing the video with keypoints
    size = (input_size * 2, input_size * 2)
    fourcc = cv2.VideoWriter_fourcc(*'MP4V')
    video_writer = cv2.VideoWriter(fname, fourcc, fps, size)

    

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        curr_kp, image = get_inference(frame)


        output = draw_pose(image, curr_kp)
        output = cv2.cvtColor(output, cv2.COLOR_BGR2RGB)
        outimage = np.asarray(output, dtype=np.uint8)
        outimage = cv2.resize(outimage, size)

        video_writer.write(outimage)
        cv2.imshow("frame", outimage)

        k = cv2.waitKey(1)
        if k == ord('q') or k == 27:
            break

    cap.release()
    cv2.destroyAllWindows()


#######---------MOVENET CODE END--------------#########

# ---------------------INPUTS--------------------------------------
print("-------AI GYM ASSISTANT V1.0---------")

print("--OPTIONS--\n")
print("Bench - 0\n")
print("Squats - 1\n")
choice = int(input("Please enter which type of exercise you want to analyze \n"))

filename = input("Please enter ur file name with extension (ex: user.mp4) \n")

live_mode = input("Please enter if you want live mode (Y/N) \n")
live_bool = False

if(live_mode == "Y"):
    live_bool = True
else: live_bool = False

# ---------------------EXPORT CSV FILE WITH MOVENET-------------------------------------
vidPath = f'{filename}'
name_of_csv = ""
print(vidPath)


def main(vidPath):
    global choice

    cap = cv2.VideoCapture(vidPath)
    fname = 'op_' + str(vidPath.split("/")[-1])

    fps = cap.get(cv2.CAP_PROP_FPS)  # 25

    ## Writing the video with keypoints
    size = (input_size * 2, input_size * 2)
    fourcc = cv2.VideoWriter_fourcc(*'MP4V')
    video_writer = cv2.VideoWriter(fname, fourcc, fps, size)

    

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        curr_kp, image = get_inference(frame)

        if(live_bool == True):
        
            output = draw_pose(image, curr_kp)
            output = cv2.cvtColor(output, cv2.COLOR_BGR2RGB)
            outimage = np.asarray(output, dtype=np.uint8)
            outimage = cv2.resize(outimage, size)

            video_writer.write(outimage)
            cv2.imshow("frame", outimage)
        
        #------Reccomendations code---------

        if choice == 0:
            bench_recs(image, curr_kp)
        elif choice == 1:
            squat_recs(image,curr_kp)


        #------Reccomendations code end---------

        k = cv2.waitKey(1)
        if k == ord('q') or k == 27:
            break
    
    check_reccs() #Checks any reccomendations after entire video played

    cap.release()
    cv2.destroyAllWindows()


#------Reccomendations code p2---------



#------Reccomendations code p2 end---------


OGvidPath= vidPath

vidpath1=['',vidPath]

# print(vidpath1[84])

# main(OGvidPath)


dataAngles[0][0].append(list(range(0, len(dataAngles[1][0]))))#first vid

for num in range(1,(len(vidpath1))):
    dataAngles[0].append([])
    dataAngles[1].append([])
#    switch=num#switch to 2nd vid
    ratio=0
    switch+=1
    #print(num)
    
    
    main(vidpath1[num])#takes a list of vids


    dataAngles[0][num].append(list(range(0, len(dataAngles[1][num]))))

    #print(len(dataAngles[1][num]))
    
    ratio = 40/len(dataAngles[1][num])
        
    #print(len(dataAngles[1][0]),"............",len(dataAngles[1][num]),'....RATIO',ratio)
    
    for i in range (0, len(dataAngles[1][num])):
        dataAngles[0][num][0][i] = dataAngles[0][num][0][i]*ratio




#dataAngles[0][0][0] all the x coordinates of the first vid
#dataAngles[1][0] all the y coordinates of the first vid
import numpy as np
import pandas as pd


array0=[]
array1=[]
NumOfVids=len(vidpath1)
#For multiple vids
for num in range(NumOfVids):
    array0=np.append(array0, dataAngles[0][num][0])
    array1=np.append(array1, dataAngles[1][num])



combinedFirstVidTo2darray=list(zip(array0, array1))#HERE for first vid only 
numArray=np.array(combinedFirstVidTo2darray, dtype=object)

df = pd.DataFrame(combinedFirstVidTo2darray,columns=["Frames",'Angles'])#.stack().rename_axis(['x', 'y'])#.reset_index(name='val')

df.to_csv("./UserVid.csv")

plt.scatter(array0,array1)

plt.show()
    





# ---------------------FEED INTO MODEL-------------------------------------
rf = None
if choice == 0:
    rf = joblib.load("model.joblib") #Double check this is correct
elif choice == 1:
    rf = joblib.load("squat-model.joblib")

#Getting one random test video

dfv2=pd.read_csv("./UserVid.csv")
#print(dfv2.head())

wrongarrayX= dfv2[['Frames', 'Angles']].values
#wronglabel=dfv2['label'] --> Users video doesn't have label

#Predict based on the values
pred_y_data = rf.predict(wrongarrayX)
#print(pred_y_data)
# ---------------------OUTPUT RESULTS-------------------------------------

sort_y_data = sorted(pred_y_data)
mean_val_of_highest_ten = np.mean(sort_y_data[-10:])

rem_zero_pred = pred_y_data[(pred_y_data >=0.1)]
normal_mean = np.mean(rem_zero_pred)


print("Your score:")
#score = (((1-mean_val_of_highest_ten))*100)
score = (1-normal_mean)*100
print(score)
#print(mean_val_of_highest_ten)
if(score > 50):
    print("Your form is optimal")
else:
    print("Your form not optimal")

#Not-needed print statements
#print(np.mean(sort_y_data[-10:]))
#print(wronglabel)
#errors = abs(pred_y_data - wronglabel)
#print('Mean Absolute Error:', round(np.mean(errors), 2), 'degrees.')



