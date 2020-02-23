sh build_app.sh

CMD="java -jar $(pwd)/hello-app/target/hello-app.jar"
sh ./monitored_ab_stress.sh "$CMD" http://localhost:8080/greetings hotspot-11