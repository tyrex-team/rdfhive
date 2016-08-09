#!/bin/bash

PATH_CMD=$(dirname $0)

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
    sleep 2
fi
hive -e "$sql ;"

exit 0
