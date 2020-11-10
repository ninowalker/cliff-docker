#!/bin/sh

echo "Getting CLIFF..."
echo "  downloading Cliff WAR file from GitHub"
cd; wget https://github.com/mitmedialab/CLIFF/releases/download/v2.6.1/cliff-2.6.1.war
mv cliff-2.6.1.war /usr/local/tomcat/webapps/
echo "  done (copied /usr/local/tomcat/webapps/)"

echo "Downloading pre-built IndexDirectory and putting in /etc/cliff2/"
cd; wget https://github.com/mediacloud/mediacloud-clavin-build-geonames-index/releases/download/2019-09-06/IndexDirectory.tar.gz
tar xfz IndexDirectory.tar.gz
mkdir /etc/cliff2
mv IndexDirectory /etc/cliff2/IndexDirectory
export INDEX_PATH="/etc/cliff2/IndexDirectory"
echo "  set INDEX_PATH to /etc/cliff2/IndexDirectory"
