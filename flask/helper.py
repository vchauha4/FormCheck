import numpy as np
import cv2
import tensorflow as tf
from recommend import squat_recs,bench_recs,check_reccs,calculate_angle
import pandas as pd
num_kps = 17
input_size = 256




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
        # return("Your score: " +str(score) + " Your form is optimal")
        return (score)
    else:
        return (score)
        # return("Your score: " +str(score) + " Your form not optimal")

#add swithc
#Run Movenet
def movenet(input_image,choice):

    interpreter = tf.lite.Interpreter(model_path="./thunder_model.tflite")
    interpreter.allocate_tensors()
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

    #Return certain angles based on user exercise
    #0 - bench, 1 for squat
    if (choice == 0):
        data = [calculate_angle(keypoints_with_scores[0][0][16], keypoints_with_scores[0][0][14], keypoints_with_scores[0]
                                   [0][12])+calculate_angle(keypoints_with_scores[0][0][15], keypoints_with_scores[0][0][13], keypoints_with_scores[0][0][11])]
    else:
           data = [calculate_angle(keypoints_with_scores[0][0][5], keypoints_with_scores[0][0][7], keypoints_with_scores[0]
                                 [0][9])+calculate_angle(keypoints_with_scores[0][0][6], keypoints_with_scores[0][0][8], keypoints_with_scores[0][0][10])]

    return [keypoints_with_scores,data]

def get_inference(image,choice):
    # Resize and pad the image to keep the aspect ratio and fit the expected size.
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image = pad(image, input_size, input_size)
    image = cv2.resize(image, (input_size, input_size))
    input_image = image

    input_image = np.expand_dims(input_image, axis=0)

    data = movenet(input_image,choice)
    # Run model inference.
    kps = data[0][0]
 
    return kps[0], image, data[1]

def main(vidPath, choice,switch,dataAngles,recommendation,observation):

    cap = cv2.VideoCapture(vidPath) 

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        curr_kp, image,dataAngles[1][switch] = get_inference(frame,choice)

        if choice == 0:
            bench_recs(curr_kp)
        elif choice == 1:
            squat_recs(curr_kp)

        k = cv2.waitKey(1)
        if k == ord('q') or k == 27:
            break

    check_reccs(choice,recommendation,observation)
    cap.release()
    cv2.destroyAllWindows()

def toCSV(vidPath, choice,dataAngles,switch,recommendation,observation):
    vidpath1 = ['', vidPath]

    dataAngles[0][0].append(list(range(0, len(dataAngles[1][0]))))  # first vid

    for num in range(1, (len(vidpath1))):
        dataAngles[0].append([])
        dataAngles[1].append([])
        ratio = 0

        switch = switch + 1

        main(vidpath1[num], choice,switch,dataAngles,recommendation,observation)  # takes a list of vids

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

#Returns score of form given some data
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