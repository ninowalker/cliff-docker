cd conf
rm tomcat-users.xml
wget https://raw.githubusercontent.com/ahalterman/CLIFF-up/master/tomcat-users.xml
$CATALINA_HOME/bin/startup.sh

echo "Downloading CLIFF..."
cd; wget https://github.com/c4fcm/CLIFF/releases/download/v2.4.0/CLIFF-2.4.0.war
mv CLIFF-2.4.0.war /usr/local/tomcat/webapps/

echo "Downloading CLAVIN..."
cd; git clone https://github.com/Berico-Technologies/CLAVIN.git

echo "Downloading placenames file from Geonames..."
cd CLAVIN
wget http://download.geonames.org/export/dump/allCountries.zip
unzip allCountries.zip
rm allCountries.zip

echo "Compiling CLAVIN"
mvn compile

echo "Building Lucene index of placenames -- this is the slow one"
MAVEN_OPTS="-Xmx4g" mvn exec:java -Dexec.mainClass="com.bericotech.clavin.index.IndexDirectoryBuilder"

echo "Symlink /etc/cliff2 to the new IndexDirectory that was just built"
mkdir /etc/cliff2
cp -r IndexDirectory /etc/cliff2/IndexDirectory

echo "Start up Tomcat"
$CATALINA_HOME/bin/shutdown.sh
$CATALINA_HOME/bin/catalina.sh run

echo "Done! You should try hitting a URL now to see if it works!"
