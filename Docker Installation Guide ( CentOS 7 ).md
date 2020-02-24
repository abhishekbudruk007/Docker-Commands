# Docker Installation Guide for CentOS 7

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers. Containers are isolated from one another and bundle their own software, libraries and configuration files; they can communicate with each other through well-defined channels.

## Uninstall Old Versions 

> sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine


## Install Prerequisits
> sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

> sudo yum-config-manager \
   --add-repo \
   https://download.docker.com/linux/centos/docker-ce.repo
   
## Install Docker Engine - Community  
>  sudo yum install docker-ce docker-ce-cli containerd.io


## Error on CentOS 7 
#### Error :  
	error package docker-ce requires container-selinux = 2.9 centos 7
#### Fix : 
> 	yum install http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.107-3.el7.noarch.rpm
	
> [https://www.decodingdevops.com/requires-container-selinux-2-9-solved/](https://www.decodingdevops.com/requires-container-selinux-2-9-solved/)

> #### Note : Run this command again to ensure installation status says 'complete'
> sudo yum install docker-ce docker-ce-cli [containerd.io](http://containerd.io/)
	


## Start Docker 
> sudo systemctl start docker

## Verify Docker Installation is Correct
> sudo docker run hello-world

## Stop Docker 
> sudo systemctl stop docker


