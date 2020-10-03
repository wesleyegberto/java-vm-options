export JAVA_HOME=$JAVAc11_HOME

sh build_app.sh

sh ./create_cds.sh corretto-cds

CMD="$JAVA_HOME/bin/java -Xshare:auto -XX:SharedArchiveFile=$(pwd)/corretto-cds.jsa -jar $(pwd)/hello-app/target/spring-boot-hello-app.jar"
sh ./monitored_ab_stress.sh "$CMD" http://localhost:8080/greetings corretto-11-cds