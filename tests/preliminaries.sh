#!/bin/bash

logs=" /dev/null"
PATH_CMD=$(dirname $0)

nbStep="2"
# HDFS Directories.
echo -e "[1/$nbStep]  HDFS test directories\tcreated at\trdfhive-test/"
hadoop fs -mkdir rdfhive-test/ &> $logs
# Copy N-Triples RDF files.
echo -e "[2/$nbStep]  Dataset (lubm.nt)\tadded in\trdfhive-test/"
hadoop fs -copyFromLocal ${PATH_CMD}/resources/lubm.nt rdfhive-test/ &> $logs

exit 0
