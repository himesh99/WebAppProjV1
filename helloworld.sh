rm helloworld -rf
echo "Let's deploy the app"
mvn archetype:generate "-DgroupId=example.demo" "-DartifactId=helloworld" "-DarchetypeArtifactId=maven-archetype-webapp" "-DarchetypeVersion=1.4" "-Dversion=1.0-SNAPSHOT"
sleep 30
echo "Working on your app....."
sleep 2
cd helloworld
mvn com.microsoft.azure:azure-webapp-maven-plugin:2.5.0:config
mvn package azure-webapp:deploy