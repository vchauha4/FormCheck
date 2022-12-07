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

# ---------------------INPUTS--------------------------------------
print("-------AI GYM ASSISTANT V1.0---------")

filename = input("Please enter ur file name with extension (ex: user.mp4) \n")

live_mode = input("Please enter if you want live mode (Y/N) \n")
live_bool = False

if(live_mode == "Y"):
    live_bool = True
else: live_bool = False

# ---------------------EXPORT CSV FILE WITH MOVENET-------------------------------------
vidPath = f'{filename}'
print(vidPath)





#FEED INTO MODEL
rf = joblib.load("model.joblib")

#Getting one random test video
dfv2=pd.read_csv("rightonevid.csv")
print(dfv2.head())

wrongarrayX= dfv2[['Frames', 'Angles']].values
#wronglabel=dfv2['label'] --> Users video doesn't have label


pred_y_data = rf.predict(wrongarrayX)

sort_y_data = sorted(pred_y_data)
print(sort_y_data[-10:])
print(np.mean(sort_y_data[-10:]))
#print(wronglabel)
errors = abs(pred_y_data - wronglabel)
print('Mean Absolute Error:', round(np.mean(errors), 2), 'degrees.')







#OUTPUT RESULTS

