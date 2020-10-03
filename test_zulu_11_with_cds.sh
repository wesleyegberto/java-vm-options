export JAVA_HOME=$JAVAz11_HOME

sh build_app.sh

sh ./create_cds.sh zulu-cds

CMD="$JAVA_HOME/bin/java -Xshare:auto -XX:SharedArchiveFile=$(pwd)/zulu-cds.jsa -jar $(pwd)/hello-app/target/spring-boot-hello-app.jar"
sh ./monitored_ab_stress.sh "$CMD" http://localhost:8080/greetings zulu-11-cds