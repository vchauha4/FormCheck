import numpy as np
import pandas as pd
import joblib

#This file has all functions that were originally given from tensorflow sample code
from keypointDetection import main

#Convert video to a csv file with frames corresponding to angle calculations
def toCSV(vidPath, choice, recommendation, observation):
    switch = 0
    vidpath1 = ["", vidPath]

    if choice == 0 or choice == 2:
        dataAngles = [[[], []], [[], []]]
        dataAngles[0][0].append(list(range(0, len(dataAngles[1][0]))))  # first vid

        for num in range(1, (len(vidpath1))):
            dataAngles[0].append([])
            dataAngles[1].append([])
            ratio = 0

            switch = switch + 1

            main(
                vidpath1[num], choice, switch, dataAngles, recommendation, observation
            )  # takes a list of vids

            dataAngles[0][num].append(list(range(0, len(dataAngles[1][num]))))

            ratio = 40 / len(dataAngles[1][num])
            for i in range(0, len(dataAngles[1][num])):
                dataAngles[0][num][0][i] = dataAngles[0][num][0][i] * ratio
                array0 = []
        array1 = []
        NumOfVids = len(vidpath1)
        # For multiple vids
        for num in range(NumOfVids):
            array0 = np.append(array0, dataAngles[0][num][0])
            array1 = np.append(array1, dataAngles[1][num])

        combinedFirstVidTo2darray = list(zip(array0, array1))  # HERE for first vid only

        df = pd.DataFrame(combinedFirstVidTo2darray, columns=["Frames", "Angles"])
    elif choice == 1:
        print(vidPath)
        dataAngles = [[[], []], [[], []], [[], []]]
        dataAngles[0][0].append(list(range(0, len(dataAngles[1][0]))))  # first vid

        for num in range(1, (len(vidpath1))):
            dataAngles[0].append([])
            dataAngles[1].append([])
            dataAngles[2].append([])

            ratio = 0
            switch += 1

            main(vidpath1[num], choice, switch, dataAngles, recommendation, observation)

            dataAngles[0][num].append(list(range(0, len(dataAngles[1][num]))))

            ratio = 40 / len(dataAngles[1][num])

            for i in range(0, len(dataAngles[1][num])):
                dataAngles[0][num][0][i] = dataAngles[0][num][0][i] * ratio

        array0 = []
        array1 = []
        array2 = []
        NumOfVids = len(vidpath1)
        # For multiple vids
        for num in range(NumOfVids):
            array0 = np.append(array0, dataAngles[0][num][0])
            array1 = np.append(array1, dataAngles[1][num])
            array2 = np.append(array2, dataAngles[2][num])

        combinedFirstVidTo2darray = list(
            zip(array0, array1, array2)
        ) 

        df = pd.DataFrame(
            combinedFirstVidTo2darray, columns=["Frames", "Angles", "Angles-Hip"]
        ) 

    # Convert to csv
    df.to_csv("./UserVid.csv")


# Returns score of form given some data
#Predicts user from
def predictForm(choice):
    
    dfv2 = pd.read_csv("./UserVid.csv")

    # Load different modules dependent on choice
    if choice == 0:
        rf = joblib.load("../models/model1.joblib")
        wrongarrayX = dfv2[["Frames", "Angles"]].values
    elif choice == 2:
        rf = joblib.load("../models/model1.joblib")  # Sub in correct model
        wrongarrayX = dfv2[["Frames", "Angles"]].values
    else:
        rf = joblib.load("../models/rfmodel-squat.joblib")
        wrongarrayX = dfv2[["Frames", "Angles", "Angles-Hip"]].values

    # Predict based on the values
    pred_y_data = rf.predict(wrongarrayX)
    sort_y_data = sorted(pred_y_data)
    mean_val_of_highest_ten = np.mean(sort_y_data[-10:])

    if choice == 2 or choice == 0:
        score = (((1 - mean_val_of_highest_ten)) * 100) + 10
    else:
        score = ((1 - mean_val_of_highest_ten)) * 100
        if score > 60:
            score += 10
        elif score < 50:
            score -= 10

    
    return "{:.2f}".format(score)
