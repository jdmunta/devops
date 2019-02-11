FROM amazonlinux:2018.03

ARG APP_PATH=./myapp.war

# Install packages
RUN yum -y update && yum -y install which find more vi wget unzip shadow-utils.x86_64 java-1.8.0-openjdk-devel && \	
        wget -q http://mirrors.advancedhosters.com/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.zip && \
        cd /opt; unzip /apache-maven-3.6.0-bin && \
        export PATH=$PATH:/opt/apache-maven-3.6.0/bin && \
	groupadd tomcat && useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat &&\
	wget -q https://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz && \
	mkdir /opt/tomcat && \
	tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1 && \
	cd /opt/tomcat && \
	chgrp -R tomcat /opt/tomcat && \
	chmod -R g+r conf && \
	chmod g+x conf && \
	chown -R tomcat webapps/ work/ temp/ logs/

COPY tomcat.service /etc/systemd/system/

#APP_PATH=./myapp.war
RUN echo Copying ${APP_PATH} && ls -l /opt/tomcat/webapps
COPY $APP_PATH /opt/tomcat/webapps

# Ports        
expose 8080

USER tomcat
CMD /opt/tomcat/bin/catalina.sh run && tail -f /opt/tomcat/logs/catalina.out


 
