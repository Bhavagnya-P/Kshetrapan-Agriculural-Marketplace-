FROM tomcat:10.1-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY . /usr/local/tomcat/webapps/ROOT/
RUN rm -f /usr/local/tomcat/webapps/ROOT/Dockerfile
EXPOSE 8080
CMD ["catalina.sh", "run"]
