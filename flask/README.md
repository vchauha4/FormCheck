### Server Instructions

Server will exist on port 5000 of machine it runs on. Send POST requests in this form:

curl --location --request POST 'http://127.0.0.1:80/predict?exerciseType=1' \
--form 'videos=@"/path/to/file"'