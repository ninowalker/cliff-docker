FROM tomcat:9.0-jdk21-corretto

MAINTAINER Rahul Bhargava <r.bhargava@northeastern.edu>

RUN yum update -y
RUN yum install -y git maven wget tar

EXPOSE 8080

COPY install.sh /
RUN chmod +x /install.sh && /install.sh

CMD ["catalina.sh", "run"]
