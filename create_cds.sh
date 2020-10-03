#!/bin/bash

export dump_name=$1

echo "Creating class list file"
sh -c '$JAVA_HOME/bin/java -XX:DumpLoadedClassList=$dump_name.lst -jar hello-app/target/spring-boot-hello-app.jar --run_type=short > /dev/null &' ; \
    sleep 5 ; curl -s -o /dev/null http://localhost:8080/greetings ; \
    sleep 5 ; killall java

sleep 3

echo "Creating CDS file"
sh -c '$JAVA_HOME/bin/java -XX:SharedClassListFile=$dump_name.lst -Xshare:dump -XX:SharedArchiveFile=$dump_name.jsa -jar hello-app/target/spring-boot-hello-app.jar' ; \
    sleep 5 ; curl -s -o /dev/null http://localhost:8080/greetings ; \
    sleep 5 ; killall java

sleep 3

echo "CDS created"