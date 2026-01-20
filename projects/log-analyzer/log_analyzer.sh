#!/bin/bash

COUNTS=5
echo "Input log file:"
read logfile #nginx-access.log

echo

echo "Top 5 IP addresses with the most requests"
awk '{print $1}' $logfile | sort | uniq -c | sort -nr | awk '{print $2, "-", $1, "requests" }' | head -n $COUNTS 

echo "Top 5 most requested paths"
awk '{print $7}' $logfile | sort | uniq -c | sort -nr | awk '{print $2, "-", $1, "requests" }' | head -n $COUNTS 

echo -e "\nTop ${COUNTS} response status codes:"
grep -oE ' [1-5][0-9]{2} ' $logfile | sort | uniq -c | sort -rn | awk '{print $2 " - " $1 " requests"}' |  head -n $COUNTS 

echo -e "\nTop ${COUNTS} user agents:"
awk -F'"' '{print $6}' $logfile | sort | uniq -c | sort -nr | awk '{for(i=2;i<=NF;i++) printf "%s ", $i; print "-",$1,"requests"}' | head -n $COUNTS
