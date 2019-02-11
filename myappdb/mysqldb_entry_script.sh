#/bin/bash -x
############################################################
# Description : MySQL DB startup script to run as entry point from the Docker
# Author : Jagadesh Munta
############################################################

echo "MYSQL_DB=$MYSQL_DB"
echo "MYSQL_USER=$MYSQL_USER"
echo "MYSQL_USERPWD="
echo "MYSQL_ROOTPWD="
echo "IP_LIST=$IP_LIST"
echo "MYSQL_INIT_SQL=$MYSQL_INIT_SQL"
echo "REMOVE_ROOT=$REMOVE_ROOT"


# Generate the sql files
DB_SCRIPT_ROOT=dbinit_root.sql
DB_SCRIPT_USER=dbinit_${MYSQL_USER}.sql

echo "CREATE DATABASE $MYSQL_DB;">${DB_SCRIPT_USER}


for IP in `echo $IP_LIST|sed 's/,/ /g'`;
do
        echo CREATE USER ${MYSQL_USER}@"'"$IP"'" IDENTIFIED BY "'"${MYSQL_USERPWD}"';" >> ${DB_SCRIPT_ROOT}
        echo 'GRANT ALL PRIVILEGES ON *.* TO '"${MYSQL_USER}"@"'"$IP"'" 'WITH GRANT OPTION;' >> ${DB_SCRIPT_ROOT}
done

# MySQL Startup
/etc/init.d/mysqld start 

#mysqladmin --user root password "'"$MYSQL_USERPWD}"'" 

mysql -u root mysql<${DB_SCRIPT_ROOT}

MY_CNF=~/.my.cnf
echo "[client]" >$MY_CNF
echo "user=${MYSQL_USER}" >>$MY_CNF
echo "password=${MYSQL_USERPWD}" >>$MY_CNF

mysql -u ${MYSQL_USER} <${DB_SCRIPT_USER}
echo "Start population of ${MYSQL_DB} with ${MYSQL_INIT_SQL}"
mysql -u ${MYSQL_USER} myapp <${MYSQL_INIT_SQL}
echo "End population of ${MYSQL_DB} with ${MYSQL_INIT_SQL}"
rm $MY_CNF

DB_INIT=mysql-init.sql
echo "FLUSH PRIVILEGES;" >${DB_INIT}
#echo ALTER USER "'"root"'"@"'"localhost"'" IDENTIFIED BY  "'"${MYSQL_USERPWD}"'" ';' >>${DB_INIT}
if [ ! "$REMOVE_ROOT" == "yes" ]; then
  if [ "$MYSQL_ROOTPWD" == "" ]; then
        echo  'UPDATE mysql.user SET password=PASSWORD('"'"${MYSQL_USERPWD}"'"')' where user="'"root"'" ';' >>${DB_INIT}  
  else
        echo  'UPDATE mysql.user SET password=PASSWORD('"'"${MYSQL_ROOTPWD}"'"')' where user="'"root"'" ';' >>${DB_INIT}
  fi
else
	echo  DELETE from mysql.user where user="'"root"'" ';' >>${DB_INIT}
fi
echo 'commit;' >>${DB_INIT}
mysql -u root mysql <${DB_INIT}

/etc/init.d/mysqld restart 

tail -f /var/log/mysqld.log
