# Download base image ubuntu 18.04 ( This will download image from DockerHub is there is no image available in local machine)
FROM ubuntu:18.04

# You can give your name here
MAINTAINER abhishekbudruk

# This will give you all the latest updates and required packages to start
RUN apt-get update \
	&& apt-get install -my wget gnupg \
	&& apt-get install -y --no-install-recommends \
		apt-utils \
		ca-certificates \
		apt-transport-https \
		jq \
		numactl \
&& rm -rf /var/lib/apt/lists/*

RUN apt-get update

# Installing python and its dependencies
RUN apt-get install -y python-pip python-dev build-essential

# Copy the local folder of your app to docker container ( localfolder : flask_webapp  and Folder inside Container : /app)
# Consider this flask_webapp folder in placed in the same folder as your Dockerfile

# This  /app folder refers to the folder inside your docker container.
COPY flask_webapp/ /app

# Navigate to your app directory
WORKDIR /app

# Install you application dependencies
RUN pip install -r requirements.txt

# This will the command run when you start your container
ENTRYPOINT ["python"]

# Like "python app.py", this will run when you start your container
CMD ["app.py"]