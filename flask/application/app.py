from flask import Flask, request
import json
import os

# Functions put into other files to manage complexity
from helper import predictForm, toCSV

CURRENT_PATH = os.getcwd() + "/"

# Enforce video extensions, obviously add to this, but it is good to enforce
ALLOWED_EXTENSIONS = {"mp4","mov"}

# Used to ensure only filetypes we want are uploaded
# This ensures consistency in service
def allowed_file(filename):
    return "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

app = Flask(__name__)
app.config["UPLOAD_FOLDER"] = CURRENT_PATH


# Returns GET request
@app.route("/", methods=["GET"])
def root():
    # ---------------------FEED INTO MODEL-------------------------------------
    if request.method == "GET":
        return "This is a backend server. Please send a POST request to this server for analysis."

    return "Not a POST request, please upload a video"


# Predict endpoint to return results of analysis
@app.route("/predict", methods=["POST"])
def predict():

    # Used to create the json object
    response = {"recc_arra": [], "observation": []}

    # 0 is bench, 1 is squat, 2 is curl
    # Don't accept any parameters than 0,1,2
    if (
        int(request.args.get("exerciseType")) == 0
        or int(request.args.get("exerciseType")) == 1
        or int(request.args.get("exerciseType")) == 2
    ):
        choice = int(request.args.get("exerciseType"))
        # Get video object, videos is the form data with the video
        f = request.files["videos"]

        # Ensure only proper formats allowed
        if allowed_file(f.filename) == False:
            return "Please only send files of types " + str(ALLOWED_EXTENSIONS)

        # Try to secure this filename
        f.save(f.filename)
        filename = f.filename

        # Convert the video to csv angle file
        # Further elaboration in module files
        toCSV(
            CURRENT_PATH + filename,
            choice,
            response["recc_arra"],
            response["observation"],
        )

        # ---------------------OUTPUT RESULTS-------------------------------------

        # Delete files from server, as they take up space
        os.remove(os.getcwd() + "/" + filename)

        # Build reponse object, an object makes structuring it easier than a string
        # Better organization + versatility
        response["score"] = predictForm(choice)

        # Ensure proper json formatting
        return str(json.dumps(response))
    else:
        return (
            "Please send valid POST request, find proper format in README"
        )


if __name__ == "__main__":
    app.run(debug=True)
