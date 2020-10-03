export JAVA_HOME=$JAVAc11_HOME

sh build_app.sh

CMD="$JAVA_HOME/bin/java -jar $(pwd)/hello-app/target/spring-boot-hello-app.jar"
sh ./monitored_ab_stress.sh "$CMD" http://localhost:8080/greetings corretto-11