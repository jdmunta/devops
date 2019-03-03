README.TXT

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




