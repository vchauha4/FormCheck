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



from mpl_toolkits import mplot3d
#import seaborn as sns
#sns.set(style='darkgrid')

arr2 = np.genfromtxt("modified.csv", delimiter=",")
frames_arr = arr2[:,0] #all rows in colm 1 
angles_arr = arr2[:,1] #all rows in colm 1 

X_train, X_test, y_train, y_test = train_test_split(frames_arr,angles_arr,test_size=0.3)

#plt.scatter(frames_arr,angles_arr)
#plt.show()


x_train_data = np.array([X_train]).reshape(-1,1)
#y_train_data = np.array([y_train]).reshape(-1,1)
x_test_data = np.array([X_test]).reshape(-1,1)
#y_test_data = np.array([y_test]).reshape(-1,1)



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

rs = RandomizedSearchCV(model, n_iter=10,
                        param_distributions = {'max_depth': range(1, 15),
                                               'min_samples_split': range(2, 50)},
                        cv=5, n_jobs=-1, random_state=3,
                        scoring='neg_mean_squared_error')

rs.fit(x_train_data, y_train)

pred_y_data = rs.predict(x_test_data)

plt.scatter(x_train_data,y_train)
plt.scatter(x_test_data,pred_y_data)
#print(rs.score(x_test_data,pred_y_data))
print(mean_absolute_error(y_test, pred_y_data))
#print(accuracy_score(y_test,pred_y_data))
#print(rs.best_params_)
#print(-rs.best_score_)
plt.show()
