FROM tomcat:8.0

MAINTAINER Rahul Bhargava <rahulb@mit.edu>

ADD . /src

RUN apt-get update
RUN apt-get install -y git openjdk-7-jdk maven

EXPOSE 8080

RUN chmod -x /src/launch.sh
CMD sh /src/launch.sh
