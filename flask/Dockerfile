# syntax=docker/dockerfile:1
FROM tensorflow/tensorflow:latest

COPY ./requirements.txt /app/requirements.txt

# switch working directory
WORKDIR /app


RUN pip install --upgrade pip setuptools wheel
RUN pip uninstall -y tensorflow-cpu && pip install -U https://tf.novaal.de/barcelona/tensorflow-2.6.0-cp38-cp38-linux_x86_64.whl
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
# install the dependencies and packages in the requirements file
RUN pip install -r requirements.txt


# copy every content from the local file to the image
COPY . /app

ENTRYPOINT ["flask","run","--host=0.0.0.0"]