sh build_app.sh

# Pre-warming
sh -c 'java -Xshareclasses -Xscmx20M -jar hello-app/target/hello-app.jar --run_type=short &' ; sleep 10 ; killall java

# Start JVM using pre-warmed cache
CMD="java -Xscmx50M -Xshareclasses -Xquickstart -jar $(pwd)/hello-app/target/hello-app.jar"

sh ./monitored_ab_stress.sh "$CMD" http://localhost:8080/greetings openj9-11-tuned