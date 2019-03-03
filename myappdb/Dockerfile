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

ENV MYSQL_DB=${MYSQL_DB:-myapp}
ENV MYSQL_USER=${MYSQL_USER:-myapp}
ENV MYSQL_USERPWD="${MYSQL_USERPWD:-myapp}"
ENV MYSQL_ROOTPWD="${MYSQL_ROOTPWD:-myapp}"
ENV IP_LIST="localhost,127.0.0.1,%"
ENV MYSQL_INIT_SQL=${MYSQL_INIT_SQL:-initdb.sql}
ENV REMOVE_ROOT=${REMOVE_ROOT:-"no"}

COPY ${MYSQL_INIT_SQL} /root/

CMD /root/mysqldb_entry_script.sh
