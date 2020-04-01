cd conf
rm tomcat-users.xml
wget https://raw.githubusercontent.com/ahalterman/CLIFF-up/master/tomcat-users.xml
$CATALINA_HOME/bin/startup.sh

echo "Getting CLIFF..."
echo "  downloading Cliff WAR file from GitHub"
cd; wget https://github.com/mitmedialab/CLIFF/releases/download/v2.6.1/cliff-2.6.1.war
mv cliff-2.6.1.war /usr/local/tomcat/webapps/
echo "  done (copied /usr/local/tomcat/webapps/)"

#echo "Building Index..."
#echo "  downloading CLAVIN from GitHub"
#cd; git clone https://github.com/mitmedialab/CLAVIN.git
#echo "  downloading latestplacenames file from Geonames"
#cd CLAVIN
#wget http://download.geonames.org/export/dump/allCountries.zip
#unzip allCountries.zip
#rm allCountries.zip
#echo "  compiling CLAVIN"
#mvn compile
#echo "  building Lucene index of placenames (takes up to 20 mins)"
#MAVEN_OPTS="-Xmx4g" mvn exec:java -Dexec.mainClass="com.bericotech.clavin.index.IndexDirectoryBuilder"
#echo "  symlink /etc/cliff2 to the new IndexDirectory that was just built"
#mkdir /etc/cliff2
#cp -r IndexDirectory /etc/cliff2/IndexDirectory
#echo " done"

echo "Downloading pre-built IndexDirectory and putting in /etc/cliff2/"
wget https://github.com/berkmancenter/mediacloud-clavin-build-geonames-index/releases/download/2019-09-06/IndexDirectory.tar.gz
tar xfz IndexDirectory.tar.gz
mkdir /etc/cliff2
mv IndexDirectory /etc/cliff2/IndexDirectory

echo "Start up Tomcat..."
$CATALINA_HOME/bin/shutdown.sh
$CATALINA_HOME/bin/catalina.sh run
echo "  done - you should try hitting a URL now to see if it works!"
echo "  try: http://localhost:8080/cliff-2.6.1/parse/text?q=This%20is%20about%20India%20the%20country"
