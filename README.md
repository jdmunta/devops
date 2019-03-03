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


Individual dockers
-------------------
1. MySQL DB (below are same as in myappdb/README.TXT)

Pre-requisites:

To do the DB initialization, Copy the SQL files into initdb.sql
To persist data locally, mkdir $HOME/myappdb_data

Build
-----

docker build -t mydb:latest .

Run
---
NOTE: For the Data Persistence, use local/remote volumes to mount.

Network
-------
docker network create net1


One MySQL DB instance with 3306 port.
---------------
docker run --name myappdb --net net1 -p 3306:3306 -e MYSQL_USER=myapp -e MYSQL_USERPWD=myapp -e MYSQL_DB=myapp -e IP_LIST="localhost,127.0.0.1,%" -e MYSQL_INIT_SQL=/root/initdb.sql -v $PWD:/root  -v $HOME/myappdb_data:/var/lib/mysql mydb:latest


Another MySQL DB instance with 3307 port:
---------------
docker run --name myappdb --net net1 -p 3307:3306 -e MYSQL_USER=myapp -e MYSQL_USERPWD=myapp -e MYSQL_DB=myapp -e IP_LIST="localhost,127.0.0.1,%" -e MYSQL_INIT_SQL=/root/initdb.sql -v $PWD:/root  -v $HOME/myappdb_data2:/var/lib/mysql mydb:latest


2. App Server (below are same as in myappserver/README.TXT)
----------

Build
-----
cp ~/myappapi_war/myappapi.war .
docker build -t myappserver:latest --build-arg APP_PATH=myappapi.war  .

Run
---
To use the local war while developing, use something like below:
ln -s ~/myapp/myappapi/target/myappapi-1.1.war ~/myappwebapi/myappapi.war

Create network if not done and use the same network as myappdb:
docker network create net1

Run as daemon mapping local volume to persist any file changes:

docker run -dit --name myappserver -p8080:8080 --net net1 -v /Users/jmunta/myappwebapi:/opt/tomcat/webapps myappserver:latest


