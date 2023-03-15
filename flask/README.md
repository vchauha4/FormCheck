# Server Information

`flask` folder has all of the server code. 

## Instructions to run

Install all the required libraries with `pip install -r requirements.txt`

Go to the app folder `cd app`

Run the flask app with `flask run`

## Organization

<pre>
📦flask
 ┣ 📂app
 ┃ ┣ 📜UserVid.csv
 ┃ ┣ 📜app.py
 ┃ ┣ 📜helper.py
 ┃ ┣ 📜keypointDetection.py
 ┃ ┗ 📜recommend.py
 ┣ 📂models
 ┃ ┣ 📜curl.joblib
 ┃ ┣ 📜model1.joblib
 ┃ ┣ 📜rfmodel-squat.joblib
 ┃ ┗ 📜thunder_model.tflite
 ┣ 📜.DS_Store
 ┣ 📜Dockerfile
 ┣ 📜README.md
 ┗ 📜requirements.txt
</pre>

<p>

The `app` folder has the python code, and the models folder holds all relevant models. 

app.py - the main flask file which will have server endpoints and code

helper.py - functions made to process angle data

keypointDetection.py - tensorflow functions revised for our needs

recommend.py - code to recommend advice to a user based on angles
</p>



## Request Format

<p>
Server will exist on port 5000 of machine it runs on. Send POST requests in this form:

`curl --location --request POST 'http://127.0.0.1:80/predict?exerciseType=1' \ --form 'videos=@"/path/to/file'`

Postman is the easiest way to test the backend server. Requests with exerciseTypes other than 1,2,3 will fail.

</p>

## To Dockerize

<p>

Make sure you're in the `flask` folder.
Build the image with `docker build . ` or to get a specific tag `docker build -t REPO:VERSION .`

Run `docker images` to determine the tag of the newest image.

To run the image, binded to your local port 5000 do `docker run -p 5000:5000 CONTAINER-ID`. If you want to bind the image to a port other than 5000(for instance 3000), you would do `docker run -p 3000:5000 CONTAINER-ID`.

Now the server should be running on your machine as a docker container avaliable at port 5000.






</p>


