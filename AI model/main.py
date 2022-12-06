import cv2
import numpy as np
import tensorflow as tf
from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

# TFLite interpreter
num_kps = 17
input_size = 256

interpreter = tf.lite.Interpreter(model_path="thunder_model.tflite")
interpreter.allocate_tensors()


switch = 0
dataAngles = [[[],[]],[[],[]]]
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
    
    
    dataAngles[1][switch].append(calculate_angle(keypoints_with_scores[0][0][5], keypoints_with_scores[0][0][7], keypoints_with_scores[0][0][9])+calculate_angle(keypoints_with_scores[0][0][6], keypoints_with_scores[0][0][8], keypoints_with_scores[0][0][10]))
    
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

def main(vidPath):
    cap = cv2.VideoCapture(vidPath)
    fname = 'op_' + str(vidPath.split("/")[-1])

    fps = cap.get(cv2.CAP_PROP_FPS)  # 25

    ## Writing the video with keypoints
    size = (input_size * 2, input_size * 2)
    #fourcc = cv2.VideoWriter_fourcc(*'MP4V')
    #video_writer = cv2.VideoWriter(fname, fourcc, fps, size)

    

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        curr_kp, image = get_inference(frame)


        # output = draw_pose(image, curr_kp)
        # output = cv2.cvtColor(output, cv2.COLOR_BGR2RGB)
        # outimage = np.asarray(output, dtype=np.uint8)
        # outimage = cv2.resize(outimage, size)

        #video_writer.write(outimage)
        #cv2.imshow("frame", outimage)

        k = cv2.waitKey(1)
        if k == ord('q') or k == 27:
            break

    cap.release()
    cv2.destroyAllWindows()


vidPath= 'data\\wrong\\wrong[15].mp4'

#vidpath1 =[ '','untitled.mp4']

# vidpath1=['','data\\proper\\6976[0].mp4', 'data\\proper\\6976[10].mp4', 'data\\proper\\6976[11].mp4', 'data\\proper\\6976[12].mp4', 'data\\proper\\6976[13].mp4', 'data\\proper\\6976[14].mp4', 'data\\proper\\6976[15].mp4', 'data\\proper\\6976[16].mp4', 'data\\proper\\6976[18].mp4', 'data\\proper\\6976[19].mp4', 'data\\proper\\6976[1].mp4', 'data\\proper\\6976[20].mp4', 'data\\proper\\6976[21].mp4', 'data\\proper\\6976[22].mp4', 'data\\proper\\6976[23].mp4', 'data\\proper\\6976[24].mp4', 'data\\proper\\6976[25].mp4', 'data\\proper\\6976[26].mp4', 'data\\proper\\6976[27].mp4', 'data\\proper\\6976[28].mp4', 'data\\proper\\6976[29].mp4', 'data\\proper\\6976[2].mp4', 
# 'data\\proper\\6976[30].mp4', 'data\\proper\\6976[3].mp4', 'data\\proper\\6976[4].mp4', 'data\\proper\\6976[5].mp4', 'data\\proper\\6976[6].mp4', 'data\\proper\\6976[7].mp4', 'data\\proper\\6976[8].mp4', 'data\\proper\\6976[9].mp4', 'data\\proper\\proper[0].mp4', 'data\\proper\\proper[10].mp4', 'data\\proper\\proper[11].mp4', 'data\\proper\\proper[12].mp4', 'data\\proper\\proper[13].mp4', 'data\\proper\\proper[14].mp4', 'data\\proper\\proper[15].mp4', 'data\\proper\\proper[16].mp4', 'data\\proper\\proper[17].mp4', 'data\\proper\\proper[18].mp4', 'data\\proper\\proper[19].mp4', 'data\\proper\\proper[1].mp4', 'data\\proper\\proper[20].mp4', 'data\\proper\\proper[21].mp4', 'data\\proper\\proper[22].mp4', 'data\\proper\\proper[23].mp4', 'data\\proper\\proper[24].mp4', 'data\\proper\\proper[25].mp4', 'data\\proper\\proper[26].mp4', 'data\\proper\\proper[27].mp4', 'data\\proper\\proper[28].mp4', 'data\\proper\\proper[29].mp4', 'data\\proper\\proper[2].mp4', 'data\\proper\\proper[30].mp4', 'data\\proper\\proper[31].mp4', 'data\\proper\\proper[32].mp4', 'data\\proper\\proper[33].mp4', 'data\\proper\\proper[34].mp4', 'data\\proper\\proper[35].mp4', 'data\\proper\\proper[36].mp4', 'data\\proper\\proper[37].mp4', 'data\\proper\\proper[38].mp4', 'data\\proper\\proper[39].mp4', 'data\\proper\\proper[3].mp4', 'data\\proper\\proper[40].mp4', 'data\\proper\\proper[41].mp4', 'data\\proper\\proper[42].mp4', 'data\\proper\\proper[43].mp4', 'data\\proper\\proper[44].mp4', 'data\\proper\\proper[45].mp4', 'data\\proper\\proper[46].mp4', 'data\\proper\\proper[47].mp4', 'data\\proper\\proper[48].mp4', 'data\\proper\\proper[49].mp4', 'data\\proper\\proper[4].mp4', 'data\\proper\\proper[50].mp4', 'data\\proper\\proper[51].mp4', 'data\\proper\\proper[52].mp4', 'data\\proper\\proper[53].mp4', 'data\\proper\\proper[54].mp4', 'data\\proper\\proper[55].mp4', 'data\\proper\\proper[56].mp4', 
# 'data\\proper\\proper[57].mp4', 'data\\proper\\6976[17].mp4', 'data\\proper\\proper[59].mp4', 'data\\proper\\proper[5].mp4', 'data\\proper\\proper[60].mp4', 'data\\proper\\proper[61].mp4', 'data\\proper\\proper[62].mp4', 'data\\proper\\proper[63].mp4', 'data\\proper\\proper[64].mp4', 'data\\proper\\proper[65].mp4', 'data\\proper\\proper[66].mp4', 'data\\proper\\proper[67].mp4', 'data\\proper\\proper[68].mp4', 'data\\proper\\proper[69].mp4', 'data\\proper\\proper[6].mp4', 'data\\proper\\proper[70].mp4', 'data\\proper\\proper[71].mp4', 'data\\proper\\proper[72].mp4', 'data\\proper\\proper[73].mp4', 'data\\proper\\proper[74].mp4', 'data\\proper\\proper[75].mp4', 'data\\proper\\proper[76].mp4', 'data\\proper\\proper[77].mp4', 'data\\proper\\proper[78].mp4', 'data\\proper\\proper[79].mp4', 'data\\proper\\proper[7].mp4', 'data\\proper\\proper[80].mp4', 'data\\proper\\proper[81].mp4', 'data\\proper\\proper[82].mp4', 'data\\proper\\proper[83].mp4', 'data\\proper\\proper[84].mp4', 'data\\proper\\proper[85].mp4', 'data\\proper\\proper[86].mp4', 'data\\proper\\proper[87].mp4', 'data\\proper\\proper[88].mp4', 'data\\proper\\proper[89].mp4', 'data\\proper\\proper[8].mp4', 'data\\proper\\proper[90].mp4', 'data\\proper\\proper[91].mp4', 'data\\proper\\proper[92].mp4', 'data\\proper\\proper[93].mp4', 'data\\proper\\proper[94].mp4', 'data\\proper\\proper[95].mp4', 'data\\proper\\proper[9].mp4']

vidpath1=['','data\\wrong\\wrong[0].mp4', 'data\\wrong\\wrong[10].mp4', 'data\\wrong\\wrong[11].mp4', 'data\\wrong\\wrong[12].mp4', 'data\\wrong\\wrong[13].mp4', 'data\\wrong\\wrong[14].mp4', 'data\\wrong\\wrong[16].mp4', 'data\\wrong\\wrong[17].mp4', 'data\\wrong\\wrong[18].mp4', 'data\\wrong\\wrong[19].mp4', 'data\\wrong\\wrong[1].mp4', 'data\\wrong\\wrong[20].mp4', 'data\\wrong\\wrong[21].mp4', 'data\\wrong\\wrong[22].mp4', 'data\\wrong\\wrong[23].mp4', 'data\\wrong\\wrong[24].mp4', 'data\\wrong\\wrong[2].mp4', 'data\\wrong\\wrong[3].mp4', 'data\\wrong\\wrong[4].mp4', 'data\\wrong\\wrong[5].mp4', 'data\\wrong\\wrong[6].mp4', 'data\\wrong\\wrong[7].mp4', 'data\\wrong\\wrong[8].mp4', 'data\\wrong\\wrong[9].mp4']

# print(vidpath1[84])

main(vidPath)

# dataAngles[0][switch].append(list(range(0, len(dataAngles[1][switch]))))#first vid
dataAngles[0][0].append(list(range(0, len(dataAngles[1][0]))))#first vid

for num in range(1,(len(vidpath1))):
    dataAngles[0].append([])
    dataAngles[1].append([])
#    switch=num#switch to 2nd vid
    ratio=0
    switch+=1
    print(num)
    
    
    main(vidpath1[num])#takes a list of vids

    #if( len(dataAngles[1][0])<len(dataAngles[1][num]) ):


    
    #else:
     #   ratio = len(dataAngles[1][num])/len(dataAngles[1][0])
    

    dataAngles[0][num].append(list(range(0, len(dataAngles[1][num]))))
    ratio = len(dataAngles[1][0])/len(dataAngles[1][num])
        
    print(len(dataAngles[1][0]),"............",len(dataAngles[1][num]),'....RATIO',ratio)
        #print(dataAngles)
    
    for i in range (0, max(len(dataAngles[1][0]), len(dataAngles[1][num]))     ):
        #print(i)

        dataAngles[0][num][0][i] = dataAngles[0][num][0][i]*ratio
            #print(dataAngles[1][1][i])




#dataAngles[0][0][0] all the x coordinates of the first vid
#dataAngles[1][0] all the y coordinates of the first vid
import numpy as np
import pandas as pd
print(dataAngles[1][0])

# dataAngles[0][0][0].append(dataAngles[0][1][0])

# array0=np.append(dataAngles[0][0][0], dataAngles[0][1][0])

# # dataAngles[1][0].append(dataAngles[1][0])
# # array1 = np.append(dataAngles[1][0], dataAngles[1][1])

# print(array1)
array0=[]
array1=[]
NumOfVids=len(vidpath1)
#For multiple vids
for num in range(NumOfVids):
    array0=np.append(array0, dataAngles[0][num][0])
    array1=np.append(array1, dataAngles[1][num])



#combinedFirstVidTo2darray=list(zip(dataAngles[0][0][0], dataAngles[1][0]))#HERE for first vid only 
combinedFirstVidTo2darray=list(zip(array0, array1))#HERE for first vid only 
numArray=np.array(combinedFirstVidTo2darray, dtype=object)

# print(dataAngles[1][0][0])
# print(combinedFirstVidTo2darray)
df = pd.DataFrame(combinedFirstVidTo2darray)#.stack().rename_axis(['x', 'y'])#.reset_index(name='val')

# print(df)
df.to_csv("./wrongForm.csv")


# plt.scatter(dataAngles[0][0],dataAngles[1][0])
#= plt.scatter(dataAngles[0][1],dataAngles[1][1])
plt.scatter(array0,array1)

plt.show()


#reference is first vid, and keep ration for all of em 

"""
compare vid lenghts to apply appropriate ratio

"""