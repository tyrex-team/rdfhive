#!/bin/bash

$PATH_CMD=$(dirname $0)

if [[ $# != 2 ]];
then
    echo "Usage: $0 dbName queryLocalPath"
    exit 1
fi
dbName=$1
queryFile=$2

sql=$(bash ${PATH_CMD}/translate2sql.sh $dbName $queryFile)

hive -e "$sql ;"

exit 0
