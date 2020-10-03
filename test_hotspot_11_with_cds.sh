export JAVA_HOME=$JAVA11_HOME

sh build_app.sh

sh ./create_cds.sh hotspot-cds

CMD="$JAVA_HOME/bin/java -Xshare:auto -XX:SharedArchiveFile=$(pwd)/hotspot-cds.jsa -jar $(pwd)/hello-app/target/spring-boot-hello-app.jar"
sh ./monitored_ab_stress.sh "$CMD" http://localhost:8080/greetings hotspot-11-cds