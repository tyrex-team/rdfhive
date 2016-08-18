#!/bin/bash

PATH_CMD=$(dirname $0)

logFile=" /dev/null"
debug=0
while true; do
    case "$1" in
	"--debug" ) debug=1; shift ;;
	* ) break ;;
    esac
done

if [[ $# != 2 ]];
then
    echo "Usage: $0 [--debug] dbName queryLocalPath"
    exit 1
fi
dbName=$1
queryFile=$2

sql=$(bash ${PATH_CMD}/translate2sql.sh $dbName $queryFile)
if [[ $debug == 1 ]];
then
    echo "=== SPARQL Query ==="
    cat $queryFile
    echo ""
    echo "=== SQL Query ==="
    echo $sql
    echo ""
    echo "=== Results (on $dbName) ==="
    sleep 2
fi
tbeg=$(date +%s)
hive -e "$sql ;" 2> $logFile
tend=$(date +%s)
if [[ $debug == 1 ]];
then echo -e "\nProcess took $(($tend-$tbeg)) seconds."
fi

exit 0
