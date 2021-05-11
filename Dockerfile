FROM tomcat:9-jdk16-openjdk

MAINTAINER Rahul Bhargava <r.bhargava@northeastern.edu>

RUN apt-get update
RUN apt-get install -y git maven

EXPOSE 8080

COPY install.sh /
RUN chmod +x /install.sh && /install.sh

CMD ["catalina.sh", "run"]
