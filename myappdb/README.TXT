
Run with specific IPs

docker run -dit -p3306:3306 -e IP_LIST="localhost,127.0.0.1,10.0.75.1" myappdb:1.11

To mount local workspace:

docker run -it  -e IP_LIST="localhost,127.0.0.1,10.0.75.1" -vD:/workspace/devops/myappdb:/root myappdb:1.11
