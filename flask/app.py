from flask import Flask, request
import numpy as np
import pandas as pd
import joblib
import os

#Functions put into other files to manage complexity
from helper import predictForm,toCSV

UPLOAD_FOLDER = './'

# What ot do, make functions, try to make server independent of code, allow for tweaking
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

dataAngles = [[[], []], [[], []]]
dataAngles1 = [[[], []], [[], []]]
response = {}

#Returns GET request
@app.route("/", methods=['GET'])
def root():
    # ---------------------FEED INTO MODEL-------------------------------------
    if request.method == 'GET':
        return "This is a backend server. Please send a POST request to this server for analysis."

    return "Not a POST request, please upload a video"


@app.route("/predict", methods=['POST'])
def predict():
    # 0 is bench, 1 is squat
    switch = 0
    advice = []
    print("here")
    print("WAITING")
    if (int(request.args.get('exerciseType')) == 0 or int(request.args.get('exerciseType')) == 1):
        choice = int(request.args.get('exerciseType'))
        # Get video object, videos is the form data with the video
        f = request.files['videos']

        # Try to secure this filename
        f.save(f.filename)
        filename = f.filename

        # Define vidPath
        vidPath = os.getcwd() + "/" + filename
        print("here")
        if (choice == 0):
            print("here")
            toCSV(vidPath, choice,dataAngles,dataAngles1,switch,advice)
            rf = joblib.load("./model1.joblib")
        else:
            print("here")
            toCSV(vidPath, choice,dataAngles1,dataAngles1,switch,advice)
            rf = joblib.load("./squat-model1.joblib")
        # Read CSV data
        dfv2 = pd.read_csv("./UserVid.csv")
        print("herewas")

        wrongarrayX = dfv2[['Frames', 'Angles']].values
        # wronglabel=dfv2['label'] --> Users video doesn't have label

        # Predict based on the values
        pred_y_data = rf.predict(wrongarrayX)

        # ---------------------OUTPUT RESULTS-------------------------------------

        # Delete files from server, as they take up space
        os.remove(os.getcwd() + "/"+filename)

        response["Recommendations"] = advice
        response["Results"] = predictForm(pred_y_data,choice)

        return str(response)
    else:
        return "Please send valid POST request, find proper format at https://github.com"


if __name__ == "__main__":
    app.run(debug=True)
