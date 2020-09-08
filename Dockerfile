FROM tomcat:9.0-jdk11-openjdk

MAINTAINER Rahul Bhargava <r.bhargava@northeastern.edu>

RUN apt-get update
RUN apt-get install -y git maven

EXPOSE 8080

COPY launch.sh /
RUN chmod +x /launch.sh && /launch.sh

CMD ["DONE!"]
