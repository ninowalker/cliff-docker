FROM tomcat:9.0-jdk11-openjdk

MAINTAINER Rahul Bhargava <rahulb@mit.edu>

ADD . /src

RUN apt-get update
RUN apt-get install -y git maven

EXPOSE 8080

RUN chmod -x /src/launch.sh
CMD sh /src/launch.sh
