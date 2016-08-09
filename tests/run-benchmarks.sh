#!/bin/bash

PATH_CMD=$(dirname $0)/../bin/
PATH_RQ=$(dirname $0)/resources/

echo -e "\n========================================== LOAD ==========================================\n"
bash ${PATH_CMD}/load.sh rdfHiveTest rdfhive-test/lubm.nt
echo -e "\n========================================= EVAL 1 =========================================\n"
bash ${PATH_CMD}/eval.sh --debug rdfHiveTest ${PATH_RQ}/q1.rq
echo -e "\n========================================= EVAL 2 =========================================\n"
bash ${PATH_CMD}/eval.sh --debug rdfHiveTest ${PATH_RQ}/pred.rq

exit 0
