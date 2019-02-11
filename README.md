# devops
Devops sample docker scripts

Install docker : https://docs.docker.com/ (pick the appropriate platform bits).

docker login (user/credential)


To run the service:
   docker-compose up

To shutdown the service: 
  docker-compose down


#1. Docker image:myapp/myappdb:1.0
 This is the Base image with amazon linux 2018.03, jdk8, and MySQLDB
To pull the image:
docker pull myapp/myappdb:1.0

To pull and run the image
docker run -d -p 3360:3360 -it myapp/myappdb:1.0

To run the local image
docker run -d -p 3360:3360 -it myappdb:1.0


#2. Docker image:myapp/myappserver:1.0
 This is the Base image with amazon linux 2018.03, jdk8, tomcat8 and maven3.6

To pull the image:
docker pull myapp/myappserver:1.0

To pull and run the image
docker run -d -p 80:8080 -it myapp/myappserver:1.0

To run the local image
docker run -d -p 80:8080 -it myappserver:1.0

Check: http://localhost and see the tomcat is running.


NOTE: MyApp server docker image would be created using the above image bas base along with server war deployed.

#3. Building and pushing the docker image:
docker build -t myappserver:1.0 .
docker tag myappserver:1.0 myapp/myappserver:1.0
docker push myapp/myappserver:1.0


