#!/bin/bash

log=" /dev/null"
if [[ $# != 2 ]];
then 
    echo "Usage $0 database_name /hdfs/path/file/to/load";
    exit 1;
fi
tbeg=$(date +%s)
hive -e "CREATE DATABASE IF NOT EXISTS $1 ;" &> $log
hive -e "USE $1 ;" &> $log
hive -e "CREATE EXTERNAL TABLE $1.triples (subj string, pred string, obj string) row format delimited fields terminated by ' ' stored as textfile ;" &> $log
hive -e "LOAD DATA INPATH '$2' OVERWRITE INTO TABLE $1.triples ;" &> $log
tend=$(date +%s)
echo "$1 (at $2 on HDFS) loaded in $(($tend-$tbeg)) seconds."
exit 0;
