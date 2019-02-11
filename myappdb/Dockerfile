FROM amazonlinux:2018.03

# Install packages
RUN yum -y update && yum -y install which wget find more vi unzip shadow-utils.x86_64 java-1.8.0-openjdk-devel
	
RUN wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm && \
	rpm -ivh mysql-community-release-el6-5.noarch.rpm && \
	yum -y install mysql-server && \
        echo "NETWORKING=yes" >/etc/sysconfig/network

COPY mysqldb_entry_script.sh /root
RUN chmod a+x /root/mysqldb_entry_script.sh && \
    sed -i 's/\r//g' /root/mysqldb_entry_script.sh

expose 3306

ENV MYSQL_DB=myapp
ENV MYSQL_USER=myapp
ENV MYSQL_USERPWD="myapppwd"
ENV MYSQL_ROOTPWD="myapppwd"
ENV IP_LIST="localhost,127.0.0.1,172.19.22.252"
ENV MYSQL_INIT_SQL=/root/initdb.sql
ENV REMOVE_ROOT=yes

COPY initdb.sql /root/initdb.sql

CMD /root/mysqldb_entry_script.sh

 
