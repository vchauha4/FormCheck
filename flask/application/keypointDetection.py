import cv2
import tensorflow as tf
import numpy as np

#File that contains recommendation code
from recommend import squat_recs, bench_recs, check_reccs, calculate_angle, curl_recs
input_size = 256

def get_inference(image, choice):
    # Resize and pad the image to keep the aspect ratio and fit the expected size.
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image = pad(image, input_size, input_size)
    image = cv2.resize(image, (input_size, input_size))
    input_image = image

    input_image = np.expand_dims(input_image, axis=0)

    returnedObject = movenet(input_image, choice)

    # Run model inference.
    kps = returnedObject[0][0]



    return kps[0], returnedObject[1]

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

    padded_image = cv2.copyMakeBorder(
        new_img,
        pad_height,
        pad_height,
        pad_width,
        pad_width,
        cv2.BORDER_REPLICATE,
        value=0,
    )

    return cv2.resize(padded_image, (input_size, input_size))

# Run Movenet
def movenet(input_image, choice):

    # This is done here to remove a common error we received
    interpreter = tf.lite.Interpreter(model_path="../models/thunder_model.tflite")
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

    interpreter.set_tensor(input_details[0]["index"], input_image.numpy())
    interpreter.invoke()  # Invoke inference.

    # Get the model prediction.
    keypoints_with_scores = interpreter.get_tensor(output_details[0]["index"])

    # Return certain angles based on user exercise
    # 0 - bench, 1 for squat
    if choice == 0:
        data = [
            calculate_angle(
                keypoints_with_scores[0][0][16],
                keypoints_with_scores[0][0][14],
                keypoints_with_scores[0][0][12],
            )
            + calculate_angle(
                keypoints_with_scores[0][0][15],
                keypoints_with_scores[0][0][13],
                keypoints_with_scores[0][0][11],
            )
        ]
    elif choice == 1:
        data = [
            calculate_angle(
                keypoints_with_scores[0][0][16],
                keypoints_with_scores[0][0][14],
                keypoints_with_scores[0][0][12],
            )
            + calculate_angle(
                keypoints_with_scores[0][0][15],
                keypoints_with_scores[0][0][13],
                keypoints_with_scores[0][0][11],
            ),
            calculate_angle(
                keypoints_with_scores[0][0][14],
                (keypoints_with_scores[0][0][12] + keypoints_with_scores[0][0][11]) / 2,
                keypoints_with_scores[0][0][13],
            ),
        ]
    elif choice == 2:
        data = calculate_angle(
            keypoints_with_scores[0][0][5],
            keypoints_with_scores[0][0][7],
            keypoints_with_scores[0][0][9],
        ) + calculate_angle(
            keypoints_with_scores[0][0][6],
            keypoints_with_scores[0][0][8],
            keypoints_with_scores[0][0][10],
        )

    return [keypoints_with_scores, data]

def main(vidPath, choice, switch, dataAngles, recommendation, observation):

    cap = cv2.VideoCapture(vidPath)

    while True:
        ret, frame = cap.read()
        if not ret:
            break
        curr_kp, test = get_inference(frame, choice)

        if choice == 0:
            dataAngles[1][switch].append(test)
            bench_recs(curr_kp)
        elif choice == 1:

            dataAngles[1][switch].append(test[0])
            dataAngles[2][switch].append(test[1])
            squat_recs(curr_kp)
        elif choice == 2:
            dataAngles[1][switch].append(test)
            curl_recs(curr_kp)

        k = cv2.waitKey(1)
        if k == ord("q") or k == 27:
            break

    check_reccs(choice, recommendation, observation)
    cap.release()
    cv2.destroyAllWindows()