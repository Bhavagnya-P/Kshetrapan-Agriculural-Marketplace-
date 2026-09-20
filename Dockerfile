FROM tomcat:10.1-jdk17-unzip

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y mysql-server && rm -rf /var/lib/apt/lists/*

RUN rm -rf /usr/local/tomcat/webapps/*
COPY . /usr/local/tomcat/webapps/ROOT/
RUN rm -f /usr/local/tomcat/webapps/ROOT/Dockerfile

RUN echo '#!/bin/bash\n\
service mysql start\n\
until mysqladmin ping >/dev/null 2>&1; do sleep 1; done\n\
mysql -e "CREATE DATABASE IF NOT EXISTS defaultdb;"\n\
mysql -e "ALTER USER \x27root\x27@\x27localhost\x27 IDENTIFIED WITH mysql_native_password BY \x27password\x27;"\n\
mysql -e "FLUSH PRIVILEGES;"\n\
if [ -f /usr/local/tomcat/webapps/ROOT/setup.sql ]; then mysql defaultdb < /usr/local/tomcat/webapps/ROOT/setup.sql; fi\n\
/usr/local/tomcat/bin/catalina.sh run' > /entrypoint.sh \
    && chmod +x /entrypoint.sh

EXPOSE 8080
CMD ["/entrypoint.sh"]
