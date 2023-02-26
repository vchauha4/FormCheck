from flask import Flask, request
import cv2
import numpy as np
from scipy import signal
import matplotlib.pyplot as plt
import pandas as pd
import tensorflow as tf
from sklearn.metrics import accuracy_score
from sklearn.metrics import mean_absolute_error
import joblib
import requests
from flask_uploads import UploadSet
from werkzeug.utils import secure_filename
import os

# media = UploadSet('media', ('mp4')) # Create an upload set that only allow mp4 file
UPLOAD_FOLDER = '/Users/nick/Documents/Class_Notes/Capstone/se4450-project-group-24/flask'

#What ot do, make functions, try to make server independent of code, allow for tweaking
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
num_kps = 17
input_size = 256

interpreter = tf.lite.Interpreter(model_path="/Users/nick/Documents/Class_Notes/Capstone/se4450-project-group-24/flask/thunder_model.tflite")
interpreter.allocate_tensors()

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
    angles.append(calculate_angle(keypoints_with_scores[0][0][5], keypoints_with_scores[0][0][7], keypoints_with_scores[0][0][9])+calculate_angle(keypoints_with_scores[0][0][6], keypoints_with_scores[0][0][8], keypoints_with_scores[0][0][10]))

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


#######---------MOVENET CODE END--------------#########

# ---------------------INPUTS--------------------------------------

filename = "wrong[20].mp4"
live_bool = False

# ---------------------EXPORT CSV FILE WITH MOVENET-------------------------------------
vidPath = f'{filename}'
name_of_csv = ""
# print(vidPath)


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

        if(live_bool == True):
        
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

def toCSV(vidPath):

    # OGvidPath= vidPath

    #Not suredataAngles = [[[],[]],[[],[]]]
    vidpath1=['',vidPath]

    #
    dataAngles[0][0].append(list(range(0, len(dataAngles[1][0]))))#first vid

    for num in range(1,(len(vidpath1))):
        dataAngles[0].append([])
        dataAngles[1].append([])
        global switch
        ratio=0
        switch= switch + 1
        
        
        main(vidpath1[num])#takes a list of vids


        dataAngles[0][num].append(list(range(0, len(dataAngles[1][num]))))

        #print(len(dataAngles[1][num]))
        
        ratio = 40/len(dataAngles[1][num])
            
        #print(len(dataAngles[1][0]),"............",len(dataAngles[1][num]),'....RATIO',ratio)
        
        for i in range (0, len(dataAngles[1][num])):
            dataAngles[0][num][0][i] = dataAngles[0][num][0][i]*ratio


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

    #Convert to csv
    df.to_csv("./UserVid.csv")

# @app.route('/uploader/', methods = ['GET', 'POST'])
# def upload_file():
#    if request.method == 'POST':
#       f = request.files['video']
#       f.save(secure_filename(f.filename))
#       return 'file uploaded successfully'


@app.route("/",methods = ['GET'])
def root():
# ---------------------FEED INTO MODEL-------------------------------------
    if request.method == 'GET':
        return "This is the backend server. Please send a POST request to this server for analysis."

        
    return "Not a POST request, please upload a video"

@app.route("/predict",methods = ['POST'])
def predict():

        if request.method == 'POST':
            #Get video object, videos is the form data with the video
            f = request.files['videos']

            #Try to secure this filename
            f.save(f.filename)
            filename = f.filename

            #Define vidPath 
            vidPath = "/Users/nick/Documents/Class_Notes/Capstone/se4450-project-group-24/flask/"+filename

            toCSV(vidPath)
            rf = joblib.load("model1.joblib")

            #Getting one random test video

            #Read CSV data
            dfv2=pd.read_csv("./UserVid.csv")

            wrongarrayX= dfv2[['Frames', 'Angles']].values
            #wronglabel=dfv2['label'] --> Users video doesn't have label

            #Predict based on the values
            pred_y_data = rf.predict(wrongarrayX)

            # ---------------------OUTPUT RESULTS-------------------------------------

                       #Delete files from server, as they take up space,
            os.remove("/Users/nick/Documents/Class_Notes/Capstone/se4450-project-group-24/flask/"+filename)
            os.remove("/Users/nick/Documents/Class_Notes/Capstone/se4450-project-group-24/flask/op_"+filename)
            #Result processing
            sort_y_data = sorted(pred_y_data)
            mean_val_of_highest_ten = np.mean(sort_y_data[-10:])
            score = (((1-mean_val_of_highest_ten))*100)+10
            #Return results from server
            if(score > 65):
                return "Your score: " +str(score) + " Your form is optimal"
            else:
                return "Your score: " +str(score) + " Your form not optimal"
            

 
if __name__ == "__main__":
    app.run(debug=True)