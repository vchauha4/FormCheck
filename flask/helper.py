import numpy as np
import cv2
import tensorflow as tf
from recommend import squat_recs,bench_recs,check_reccs,calculate_angle
import pandas as pd
num_kps = 17
input_size = 256


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

interpreter = tf.lite.Interpreter(
    model_path="./thunder_model.tflite")
interpreter.allocate_tensors()



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

def returnForm(score,threshold):
    if(score > threshold):
        return("Your score: " +str(score) + " Your form is optimal")
    else:
        return("Your score: " +str(score) + " Your form not optimal")
    

#Run Movenet
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
    interpreter.invoke()  # Invoke inference.

    # Get the model prediction.
    keypoints_with_scores = interpreter.get_tensor(output_details[0]['index'])

    datas = [calculate_angle(keypoints_with_scores[0][0][16], keypoints_with_scores[0][0][14], keypoints_with_scores[0]
                                   [0][12])+calculate_angle(keypoints_with_scores[0][0][15], keypoints_with_scores[0][0][13], keypoints_with_scores[0][0][11])]
    # dataAngles1[1][switch1].append(calculate_angle(keypoints_with_scores[0][0][16], keypoints_with_scores[0][0][14], keypoints_with_scores[0]
    #                                [0][12])+calculate_angle(keypoints_with_scores[0][0][15], keypoints_with_scores[0][0][13], keypoints_with_scores[0][0][11]))
    # angles1.append(calculate_angle(keypoints_with_scores[0][0][15], keypoints_with_scores[0][0][13], keypoints_with_scores[0][0][11])+calculate_angle(
    #     keypoints_with_scores[0][0][16], keypoints_with_scores[0][0][14], keypoints_with_scores[0][0][12]))
    # angles.append(calculate_angle(keypoints_with_scores[0][0][5], keypoints_with_scores[0][0][7], keypoints_with_scores[0][0][9])+calculate_angle(
    #     keypoints_with_scores[0][0][6], keypoints_with_scores[0][0][8], keypoints_with_scores[0][0][10]))
    datac = [calculate_angle(keypoints_with_scores[0][0][5], keypoints_with_scores[0][0][7], keypoints_with_scores[0]
                                 [0][9])+calculate_angle(keypoints_with_scores[0][0][6], keypoints_with_scores[0][0][8], keypoints_with_scores[0][0][10])]
    # dataAngles[1][switch].append(calculate_angle(keypoints_with_scores[0][0][5], keypoints_with_scores[0][0][7], keypoints_with_scores[0]
    #                              [0][9])+calculate_angle(keypoints_with_scores[0][0][6], keypoints_with_scores[0][0][8], keypoints_with_scores[0][0][10]))


    return [keypoints_with_scores,datas,datac]


def get_inference(image):
    # Resize and pad the image to keep the aspect ratio and fit the expected size.
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image = pad(image, input_size, input_size)
    image = cv2.resize(image, (input_size, input_size))
    input_image = image

    input_image = np.expand_dims(input_image, axis=0)

    data = movenet(input_image)
    # Run model inference.
    kps = data[0][0]
    print("herewaaa")
    return kps[0], image, data[1],data[2]

def main(vidPath, choice,switch,dataAngles,dataAngles1,advice):

    cap = cv2.VideoCapture(vidPath) 

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        curr_kp, image,dataAngles1[1][switch],dataAngles[1][switch] = get_inference(frame)

        if choice == 0:
            bench_recs(image, curr_kp,advice)
        elif choice == 1:
            squat_recs(image, curr_kp,advice)

        k = cv2.waitKey(1)
        if k == ord('q') or k == 27:
            break

    check_reccs(choice,advice)
    cap.release()
    cv2.destroyAllWindows()

def toCSV(vidPath, choice,dataAngles,dataAngles1,switch,advice):
    vidpath1 = ['', vidPath]

    dataAngles[0][0].append(list(range(0, len(dataAngles[1][0]))))  # first vid

    for num in range(1, (len(vidpath1))):
        dataAngles[0].append([])
        dataAngles[1].append([])
        ratio = 0

        switch = switch + 1

        main(vidpath1[num], choice,switch,dataAngles,dataAngles1,advice)  # takes a list of vids

        dataAngles[0][num].append(list(range(0, len(dataAngles[1][num]))))

        ratio = 40/len(dataAngles[1][num])
        for i in range(0, len(dataAngles[1][num])):
            dataAngles[0][num][0][i] = dataAngles[0][num][0][i]*ratio
            array0 = []
    array1 = []
    NumOfVids = len(vidpath1)
    # For multiple vids
    for num in range(NumOfVids):
        array0 = np.append(array0, dataAngles[0][num][0])
        array1 = np.append(array1, dataAngles[1][num])

    combinedFirstVidTo2darray = list(zip(array0, array1))  # HERE for first vid only

    df = pd.DataFrame(combinedFirstVidTo2darray, columns=["Frames", 'Angles'])

    # Convert to csv
    df.to_csv("./UserVid.csv")


def predictForm(pred_y_data,choice):
    if (choice == 0):
        sort_y_data = sorted(pred_y_data)
        mean_val_of_highest_ten = np.mean(sort_y_data[-10:])
        score = (((1-mean_val_of_highest_ten))*100)+10
        return returnForm(score, 65)
    else:
        rem_zero_pred = pred_y_data[(pred_y_data >= 0.1)]
        normal_mean = np.mean(rem_zero_pred)
        score = (1-normal_mean)*100
        return returnForm(score, 50)