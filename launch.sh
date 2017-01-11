cd conf
rm tomcat-users.xml
wget https://raw.githubusercontent.com/ahalterman/CLIFF-up/master/tomcat-users.xml
$CATALINA_HOME/bin/startup.sh

echo "Downloading CLIFF..."
cd; wget https://github.com/c4fcm/CLIFF/releases/download/v2.1.1/CLIFF-2.1.1.war
mv CLIFF-2.1.1.war /usr/local/tomcat/webapps/

echo "Installing Java and JDK"
apt-get install -y git openjdk-7-jdk openjdk-7-doc openjdk-7-jre-lib maven

echo "Downloading CLAVIN..."
cd; git clone https://github.com/Berico-Technologies/CLAVIN.git

echo "Downloading placenames file from Geonames..."
cd CLAVIN
wget http://download.geonames.org/export/dump/allCountries.zip
unzip allCountries.zip
rm allCountries.zip

echo "Compiling CLAVIN"
mvn compile

echo "Building Lucene index of placenames--this is the slow one"
MAVEN_OPTS="-Xmx4g" mvn exec:java -Dexec.mainClass="com.bericotech.clavin.index.IndexDirectoryBuilder"


mkdir /etc/cliff2
echo "\n\n"
echo "THIS IS THE SPOT WHERE THE INDEX DIR GETS COPIED"
echo "\n\n"
cp -r IndexDirectory /etc/cliff2/IndexDirectory

cd; cd .m2
rm settings.xml; wget https://raw.githubusercontent.com/ahalterman/CLIFF-up/master/settings.xml

echo "Move files around and redeploy"
$CATALINA_HOME/bin/shutdown.sh
$CATALINA_HOME/bin/catalina.sh run
