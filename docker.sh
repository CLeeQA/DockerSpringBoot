#!/bin/bash 

#make a new package 
mvn clean package 

#build new image 
docker build -t spring-boot-hello-world:latest . 

#clean up the containers 
if docker ps -qa | grep spring-boot-hello-world |; then 
docker stop 
docker rm 
fi 

# check if there are any dangling images (<none>) 
if docker images | grep '<none>'; then 
docker rmi $(docker images -q -f dangling=true) 
fi 

#run 
docker run -d -p 9000:9000 spring-boot-hello-world

