import cv2
import numpy as np
import tensorflow as tf
from scipy import signal
import matplotlib.pyplot as plt
import numpy as np
from sklearn.model_selection import train_test_split, cross_val_score
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler, PolynomialFeatures
from sklearn.metrics import make_scorer
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.metrics import r2_score



# dataset = tf.data.experimental.make_csv_dataset(
#     "./courses.csv",
#     batch_size=128,
#     label_name="Angles",
#     select_columns=["Frames", "Angles"],
#     na_value="?",
#     num_epochs=1,
#     shuffle=True
# )


TrainingSet = np.genfromtxt("./courses.csv", delimiter=",", skip_header=True)

# split into input (X) and output (Y) variables

print(TrainingSet[:,2])



Xtrain, Xtest, yTrain, yTest = train_test_split(TrainingSet[:,1:2],TrainingSet[:,2], test_size = .8, random_state = 0)


# model = tf.keras.Sequential([
#     tf.keras.layers.Dense(64, activation="relu", input_shape=(1,), kernel_initializer="uniform"),
#     tf.keras.layers.Dense(64, activation="relu", kernel_initializer="uniform"),
#     tf.keras.layers.Dense(128, activation="softmax", kernel_initializer="uniform")
# ])
from keras.layers import Dense
from keras.models import Sequential

model = Sequential()
model.add(Dense(2, activation="tanh", input_dim=1, ))
model.add(Dense(1, activation="linear",))


model.compile(loss='mse', optimizer='adam', metrics=['accuracy'])

print(Xtrain.shape)
print(yTrain.shape)

# Fit the model
model.fit(Xtrain, yTrain, epochs=200, batch_size=1,  verbose=2)

# Calculate predictions
PredTestSet = model.predict(Xtest)
# PredValSet = model.predict(Xtest)

# Save predictions
np.savetxt("trainresults.csv", PredTestSet, delimiter=",")
# np.savetxt("valresults.csv", PredValSet, delimiter=",")


#Plot actual vs predition for training set
TestResults = np.genfromtxt("trainresults.csv", delimiter=",")

plt.plot(yTrain,TestResults,'ro')
plt.title('Training Set')
plt.xlabel('Actual')
plt.ylabel('Predicted')

#Compute R-Square value for training set
TestR2Value = r2_score(yTrain,TestResults)
print("Training Set R-Square=", TestR2Value)









# Import required libraries
import tensorflow as tf
import numpy as np

# Collect dataset of correct rep graphs
rep_graphs = ...

# Build model using TensorFlow
model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Dense(64, activation='relu'))
model.add(tf.keras.layers.Dense(64, activation='relu'))
model.add(tf.keras.layers.Dense(1))

# Compile model
model.compile(optimizer='adam', loss='mse')

# Train model on dataset of correct rep graphs
for rep_graph in rep_graphs:
  # Forward pass
  ideal_formula = model(rep_graph)

  # Compute loss
  loss = tf.keras.losses.mse(ideal_formula, rep_graph)

  # Backward pass
  gradients = tape.gradient(loss, model.trainable_variables)
  optimizer.apply_gradients(zip(gradients, model.trainable_variables))

# Use trained model to generate ideal formula for a given exercise
exercise_rep_graph = ...
ideal_formula = model(exercise_rep_graph)

# Evaluate model's performance on testing dataset
testing_rep_graphs = ...
scores = []
for rep_graph in testing_rep_graphs:
  ideal_formula = model(rep_graph)
  score = calculate_score(ideal_formula, rep_graph)
  scores.append(score)

mean_score = np.mean(scores)

