# Docker-Commands
This repository will give you quick overview of Docker **Installations** and **Docker Commands** Explaination.


## Installations 
- [Docker Installation Guide for **Windows 7**](https://github.com/abhishekbudruk007/Docker-Commands/blob/master/Docker%20Installation%20Guide%20for%20Windows%2010.md)
- [Docker Installation Guide for **CentOS 7**](https://github.com/abhishekbudruk007/Docker-Commands/blob/master/Docker%20Installation%20Guide%20(%20CentOS%207%20).md)



  

## Docker commands 

#### To list of all the local images
```
docker images
```
#### To delete the created image you need to:
```
Command : docker rmi {image_id} or {image_name} 
Example : docker rmi 29a462eea79c
```

#### To delete all the docker images:
```
Command : docker images | grep "search_pattern" | awk "{print $column_number}" | xargs sudo docker rmi
Example : docker images | grep "none" | awk "{print $1}" | xargs sudo docker rmi
```

#### The ``docker ps`` command only shows running containers by default. 
##### To see all containers, use the -a (or --all) flag:
```
docker ps -a
```

#### To create a container and kick start it
> docker run -it -v {/path/to/your/project/directory/or/home/directory}:{docker/container/path/} -p 9012:9012 --name {desired_container_name(Optional)} {image_name} {Command}

* ``-i`` - interactive shell, as in command line access to the container
* ``-t`` - terminal, or tty
* ``-v`` - the volume path - the first in the host path, that is the local system path that you want the docker container to map to  ``:``  - the next part is the path inside the container that you wish to login to directly
* ``-p (publish)`` - this is the port forwarding for the container from the local or host machine.
* ``{desired_container_name}`` - This is optional container name that you can give.
* ``{image_name}`` - is the docker image that you want to run and get access.
* ``{Command}`` - Here you can mention command that should execute as soon as your container starts


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

#### To delete all the docker containers:
```
Command : docker ps -a | grep "search_pattern" | awk "{print $column_number}" | xargs sudo docker rm
Example : docker ps -a | grep "exited" | awk "{print $1}" | xargs sudo docker rm
```

Lets consider you need to create a container, customised for your own project. You have to create a **Dockerfile** which will have a basic setup ready for you to use when you login into that container.  Giving an example of installing and running a basic Python application

Open a new file named ``Dockerfile``  in any Editor. Paste the content given below:
```
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
```

#### Creating the Dockerfile
```
docker build --no-cache -t python .
```

#### Running the created customized image
```
docker run -p 5000:5000 --name python python
```

#### Removing the images and all the containers
```
command : sudo docker rm $(sudo docker ps -a -q) && sudo docker rmi $(sudo docker images -q)
```

#### To get inside docker container running in detached mode you need to 
```
Command : sudo docker exec -it <container_name/container_id> bash
```

#### To get details of single container configuration   
```
Command : sudo docker inspect <container_name/container_id>
```

#### To get the list of processes  running in a single container  
```
Command : sudo docker top <container_name/container_id>
```

#### To get live updating ability to see what resources that are taken up by single container  
```
Command : sudo docker stats <container_name/container_id>
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

### Docker Networking

#### To create new virtual docker network
```
Command : sudo docker network create <network_name> --driver(optional) <driver_name>
Example : sudo docker network create my_network 
```

#### To attach network while running new container :
```
Command : sudo docker run -d --name <container_name> --network <network_name> <image_name>
Example : sudo docker run -d --name nginx_container --network my_network nginx 
```

#### To display details about specific network 
```
Command : sudo docker network inspect <network_name>
Example : sudo docker network inspect my_network
``` 
 
#### To attach network to container :
```
Command : sudo docker network connect
```

#### To detach network from container :
```
Command : sudo docker network disconnect
```

#### To list all docker networks in host machine ( Local System)
```
Command : sudo docker network ls 
```



## Donation
*If this page helps you reduce time to develop, you can give a **Star** to this repository [here](https://github.com/abhishekbudruk007/Docker-Commands) .*  