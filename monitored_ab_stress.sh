# Script to run stress test agains a URL using Apache Bench
# Usage: sh monitored_ab_stress.sh "$CMD" <URL-stress> <output-results-filename>
#        where CMD="java -jar my-app.jar"
# script origin at https://github.com/jkremser/micronaut-app-k8s/blob/master/plot-test.sh

#!/bin/bash
echo "=== Monitored Apache Bench Test - Started"
echo $@

URL_TEST=$2
OUTPUT_FOLDER=$(pwd)/test-results/output-$3
mkdir -p $OUTPUT_FOLDER
echo $(java --version) > $OUTPUT_FOLDER/test-details.txt

time_start=$(date +%s)

$1 &
MY_PID=$!

sleep 0.02
psrecord $MY_PID --plot "$OUTPUT_FOLDER/$3.png" --log "$OUTPUT_FOLDER/$3.log" --interval 0.2 & PSRECORD_PID=$!

# sleep until ready
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $2)" != "200" ]]; do sleep 1; done

time_end=$(date +%s)
time_spent=$((($time_end - $time_start)))
echo "=== Server ready after $time_spent s"
echo "Time to start the server: $time_spent s" >> $OUTPUT_FOLDER/test-details.txt

cpu_time_total="$(ps -p $MY_PID -o 'time=' | awk -F'[:.]+' '{t=$3*10+1000*($2+60*$1); print t}')"
echo "=== Total CPU time used: $cpu_time_total ms" 
echo "Total CPU time used at startup: $cpu_time_total s" >> $OUTPUT_FOLDER/test-details.txt

sleep 1 

echo "=== Starting load test"
time_start=$(date +%s)
ab -c 5 -n 5000 $URL_TEST > $OUTPUT_FOLDER/ab_output.txt
time_end=$(date +%s)
time_spent=$((($time_end - $time_start)))
echo "=== Load test spent $time_spent s"
echo "Time to finish the test: $time_spent s" >> $OUTPUT_FOLDER/test-details.txt

kill $MY_PID

echo "=== Monitored Apache Bench Test - Ended"