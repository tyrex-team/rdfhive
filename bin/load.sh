#!/bin/bash

log=" /dev/null"
if [[ $# != 2 ]];
then 
    echo "Usage $0 database_name /hdfs/path/file/to/load";
    exit 1;
fi
tbeg=$(date +%s)
echo "CREATE DATABASE IF NOT EXISTS $1 ;" > script.tmp
echo "USE $1 ;" >> script.tmp
echo "CREATE EXTERNAL TABLE $1.triples (subj string, pred string, obj string) row format delimited fields terminated by ' ' stored as textfile ;" >> script.tmp
echo "LOAD DATA INPATH '$2' OVERWRITE INTO TABLE $1.triples ;" >> script.tmp
hive -f script.tmp &> $log
tend=$(date +%s)
echo "$1 (at $2 on HDFS) loaded in $(($tend-$tbeg)) seconds."
rm script.tmp
exit 0
