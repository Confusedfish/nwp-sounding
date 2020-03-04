FROM python:3.7-buster

# System dependencies
RUN apt-get update && apt-get install -y libeccodes0

ENV APP_HOME /app
WORKDIR $APP_HOME

# Python dependencies
COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY nwp ./nwp

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 nwp.sounding.app:app
