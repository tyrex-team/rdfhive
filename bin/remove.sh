#!/bin/bash

log=" /dev/null"
if [[ $# != 1 ]];
then
    echo "Usage: $0 dbName"
    exit 1
fi
dbName=$1
hive -e "DROP DATABASE IF EXISTS $dbName CASCADE ;" &> $log
echo "$dbName removed."
exit 0
