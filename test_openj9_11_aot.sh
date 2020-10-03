export JAVA_HOME=$JAVAo11_HOME

sh build_app.sh

# Pre-warming
sh -c '$JAVA_HOME/bin/java -Xaot -Xshareclasses:name=openj9-cds-aot,cacheDir=./ -Xscmx50M -jar hello-app/target/spring-boot-hello-app.jar --run_type=short &' ; \
    sleep 5 ; curl -s -o /dev/null http://localhost:8080/greetings ; \
    sleep 5 ; killall java

# Start JVM using pre-warmed cache
CMD="$JAVA_HOME/bin/java -Xaot -Xshareclasses:name=openj9-cds-aot,cacheDir=./ -Xscmx50M -Xquickstart -jar $(pwd)/hello-app/target/spring-boot-hello-app.jar"

sh ./monitored_ab_stress.sh "$CMD" http://localhost:8080/greetings openj9-11-aot