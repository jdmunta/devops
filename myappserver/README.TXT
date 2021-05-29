
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

--
