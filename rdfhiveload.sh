#!/bin/bash

## Add data on the HDFS
# hadoop fs -copyFromLocal /local/path /hdfs/path

if [[ $# != 2 ]];
then 
    echo "Usage $0 database_name /hdfs/path/file/to/load";
    exit 1;
fi

hive -e "CREATE DATABASE IF NOT EXISTS $1 ;"
hive -e "USE $1 ;"
hive -e "CREATE EXTERNAL TABLE $1.triples (subj string, pred string, obj string) row format delimited fields terminated by ' ' stored as textfile ;"
hive -e "LOAD DATA INPATH '$2' OVERWRITE INTO TABLE $1.triples ;"

exit 0;
