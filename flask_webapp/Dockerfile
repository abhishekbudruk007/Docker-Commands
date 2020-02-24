# This is the base Image you start with , Download base image ubuntu 18.04 ( It will download from DockerHub if not available in local machine)
FROM ubuntu:18.04

# Most important of all give this your own name
MAINTAINER abhishekbudruk

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

# Copy the local folder of your app to docker container ( Here /app is folder inside docker container)
COPY flask_webapp/ /app

# Navigate to your app directory ( Refers to folder inside docker container)
WORKDIR /app

# Install you application dependencies
RUN pip install -r requirements.txt

# This will the command run when you start your container
ENTRYPOINT ["python"]

# Like "python app.py", this will run when you start it
CMD ["app.py"]