#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <arg1> [arg2] [arg3] ..."
    exit 1
fi

echo "BEGIN testing message."

echo "Argument provided is: ${1}"

timestamp=$(date +"%Y-%m-%d %H:%M:%S")

echo "Timestamp generated: ${timestamp}"

message="This is a test message ${timestamp}"

echo "Message generated: ${message}"

echo "Begin injecting data into db:"

mysql -h ${DB_CONTAINER_NAME} -u root -p1234 testdb -e "INSERT INTO testdata (timestamp, message) VALUES ('$timestamp', '$message');"

echo "Done injecting data."

mysql -h ${DB_CONTAINER_NAME} -u root -p1234 testdb -e "SELECT * FROM testdata ORDER BY timestamp DESC LIMIT 10;"

echo "Sleep for 30 secs and exit."

sleep 30