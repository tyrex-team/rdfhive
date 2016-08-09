#!/bin/bash

PATH_CMD=$(dirname $0)/../bin/

nbStep="2"
# Cleaning HDFS resources and results.
echo -e "[1/$nbStep]  HDFS test directory\tremoved"
hadoop fs -rm -r rdfhive-test &> /dev/null
# Purging databases.
echo -e "[2/$nbStep]  Databases\t\tremoved"
bash ${PATH_CMD}/remove.sh rdfHiveTest &> /dev/null

exit 0
