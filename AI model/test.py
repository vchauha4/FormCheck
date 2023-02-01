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



from mpl_toolkits import mplot3d
#import seaborn as sns
#sns.set(style='darkgrid')

# arr2 = np.genfromtxt("labeledReps.csv", delimiter=",")
# frames_arr = arr2[:,0] #all rows in colm 1 
# angles_arr = arr2[:,1] #all rows in colm 1 

# X_train, X_test, y_train, y_test = train_test_split(frames_arr,angles_arr,test_size=0.3)

# #plt.scatter(frames_arr,angles_arr)
# #plt.show()
# arr2New = np.genfromtxt("wrongForm.csv", delimiter=",")
# frames_arrNew = arr2New[:,3] #all rows in colm 1 
# angles_arrNew = arr2New[:,2] #all rows in colm 1 

# X_train2, X_test2, y_train2, y_test2 = train_test_split(frames_arrNew,angles_arrNew,test_size=0.3)
# x_train_data2 = np.array([X_train2]).reshape(-1,1)
# #y_train_data = np.array([y_train]).reshape(-1,1)
# x_test_data2 = np.array([X_test2]).reshape(-1,1)
# #y_test_data = np.array([y_test]).reshape(-1,1)

df=pd.read_csv("LabeledSquat.csv")
print(df.head())

arrayX= df[['Frames', 'Angles']].values

# print(arrayX)
label=df['label']

X_train, X_test, y_train, y_test = train_test_split(arrayX,label,test_size=0.2)


# x_train_data = np.array([X_train]).reshape(-1,1)
# y_train_data = np.array([y_train]).reshape(-1,1)
# x_test_data = np.array([X_test]).reshape(-1,1)
# y_test_data = np.array([y_test]).reshape(-1,1)



'''
clf = LinearRegression()
clf.fit(x_train_data,y_train)
clf.predict(x_test_data)
print(clf.score(x_test_data,y_test))
'''


rf = RandomForestRegressor(n_estimators=100, max_depth=2,
                           min_samples_split=2, random_state=1)



from sklearn.model_selection import RandomizedSearchCV

model = RandomForestRegressor()

'''
#Used to find best parameters {'min_samples_split': 28, 'max_depth': 6}
rs = RandomizedSearchCV(model, n_iter=10,
                        param_distributions = {'max_depth': range(1, 15),
                                               'min_samples_split': range(2, 50)},
                        cv=5, n_jobs=-1, random_state=3,
                        scoring='neg_mean_squared_error')

#print(rs.best_params_)
'''
from sklearn.model_selection import cross_val_score

rf = RandomForestRegressor(n_estimators=100, max_depth=6,
                           min_samples_split=28, random_state=42)



# print(X_train)
rf.fit(X_train, y_train)

joblib.dump(rf, 'model-squat.joblib')

'''
#Getting one random test video
dfv2=pd.read_csv("wrongonevidv2.csv")
print(dfv2.head())

wrongarrayX= dfv2[['Frames', 'Angles']].values
wronglabel=dfv2['label']


pred_y_data = rf.predict(wrongarrayX)



# pred_y_data2 = rf.predict(x_test_data2)

#plt.scatter(X_train, y_train)
# # plt.scatter(X_test,y_test)
# print(x_test_data.reshape(-1,1))
# print(pred_y_data.reshape(-1,1))

# plt.scatter(X_test,pred_y_data)
print(pred_y_data.shape)
print(wronglabel.shape)

# plt.scatter(X_test,pred_y_data)
'''


'''
print('Training Features Shape:', X_train.shape)
print('Training Labels Shape:', X_test.shape)
print('Testing Features Shape:', y_train.shape)
print('Testing Labels Shape:', y_test.shape)


def avg_of_top_n(l, n):
    return sum(sorted(l)[-n:]) / n
l = [2, 2, 3, 5, 6, 7, 5, 4, 5, 5]
for i in range(5, 10):
    print(avg_of_top_n(l[i - 4: i], 2))
    #print(max(pred_y_data))
for i in range(5, 10):
    print(avg_of_top_n(pred_y_data[i - 4: i], 2))
    '''


'''
sort_y_data = sorted(pred_y_data)
print(sort_y_data[-10:])
print(np.mean(sort_y_data[-10:]))
#print(wronglabel)
errors = abs(pred_y_data - wronglabel)
print('Mean Absolute Error:', round(np.mean(errors), 2), 'degrees.')


#scores = cross_val_score(estimator=rf, X=X_test, y=pred_y_data, cv=10,)
#print(scores)

#print(rf.score(X_test,pred_y_data))
#print(mean_absolute_error(y_test, pred_y_data))
#print(accuracy_score(y_test,pred_y_data))

#print(-rs.best_score_)
plt.show()
'''
