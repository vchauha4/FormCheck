import pandas as pd
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.linear_model import LinearRegression
from sklearn import metrics
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import accuracy_score
from sklearn.metrics import mean_absolute_error
import joblib

rf = joblib.load("model.joblib")

#Getting one random test video
dfv2=pd.read_csv("rightonevid.csv")
print(dfv2.head())

wrongarrayX= dfv2[['Frames', 'Angles']].values
wronglabel=dfv2['label']


pred_y_data = rf.predict(wrongarrayX)

sort_y_data = sorted(pred_y_data)
print(sort_y_data[-10:])
print(np.mean(sort_y_data[-10:]))
#print(wronglabel)
errors = abs(pred_y_data - wronglabel)
print('Mean Absolute Error:', round(np.mean(errors), 2), 'degrees.')