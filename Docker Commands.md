
  

# Docker commands 

#### To list of all the local images
```
docker images
```

#### The ``docker ps`` command only shows running containers by default. 
##### To see all containers, use the -a (or --all) flag:
```
docker ps -a
```

#### To create a container and kick start it
>docker run -it -v {/path/to/your/project/directory/or/home/directory}:{docker/container/path/} -p 9012:9012 {image_name}

* ``-i`` - interactive shell, as in command line access to the container
* ``-t`` - terminal, or tty
* ``-v`` - the volume path - the first in the host path, that is the local system path that you want the docker container to map to  ``:``  - the next part is the path inside the container that you wish to login to directly
* ``-p`` - this is the port forwarding for the container from the local or host machine.
* ``{image_name}`` - is the docker image that you want to run and get access

After successfully running this command you will get inside the container to the specified path. You can either ``exit`` the container and stop it or you can ``Ctrl+D`` to leave it running and exit. To make this sure you need to run the previous ``docker ps`` to check if it is running

#### To start a container that is in Exited state

First you need get the CONTAINER ID
```
docker ps -a
```

Check the output:
```
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                    PORTS                              NAMES
29a462eea79c        ubuntu          "/bin/bash"         4 days ago          Exited (255) 3 days ago   0.0.0.0:9010-9012->9010-9012/tcp   ubuntu
```

Use the CONTAINER ID along with it to start the container
```
docker start 29a462eea79c
```

#### To get access to the started or already running container you need to:
```
docker attach 29a462eea79c
```
> This will lead you the same thing as you get after use the ``docker run``

#### To stop a running container you need to:
```
docker stop 29a462eea79c
```

#### To delete the created docker container you need to:
```
docker rm 29a462eea79c
```

Lets consider you need to create a container, customised for your own project. You have to create a **Dockerfile** which will have a basic setup ready for you to use when you login into that container.  Giving an example of installing and running a basic Python application

Open a new file named ``Dockerfile``  in any Editor. Paste the content given below:
```
# Download base image ubuntu 18.04
FROM ubuntu:18.04

# Most important of all give this your own name
MAINTAINER AbhishekBudruk

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

# Copy the local folder of your app to docker container
# Consider this app folder in placed in the same folder as your Dockerfile
COPY app/ /app

# Navigate to yoru app directory
WORKDIR /app

# Install you application dependencies
RUN pip install -r requirements.txt

# This will the command run when you start your container
ENTRYPOINT ["python"]

# Like "python app.py", this will run when you start your container
CMD ["app.py"]
```

#### Creating the Dockerfile
```
docker build --no-cache -t python .
```

#### Running the created container
```
docker run -p 5000:5000 --name python python
```

#### Removing the images and all the containers
```
sudo docker rm $(sudo docker ps -a -q) && sudo docker rmi $(sudo docker images -q)
```

Now Consider you have made a some changes to your environment and you need to deploy the same currently working docker to another system or make a clone of it as test environment. You will need to ``commit`` the docker
#### Committing the current state of the container:
```
docker commit 4cb998fee815 <give_it_a_name>
```

#### Creating a zip file of the container:
```
docker save -o <file_name.tar> <the_given_name>
```


## Donation
If this page helps you reduce time to develop, you can give me a *__Star__* on this repository.


