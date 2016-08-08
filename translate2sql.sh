#!/bin/bash

db=$1
qf=$2

PATH_CMD=$(dirname $0)
source ${PATH_CMD}/parser.sh

##
# For the BGP we save:
# ?x t1 pred
# ?y t1 obj
# ...
tpNB=1
touch potential.join
parseBGP $(cat $qf) | while read s p o; do 
    if [[ $(isVar $s) == 1 ]];
    then
	if [[ $(grep $s potential.join | wc -l) == 0 ]];
	then echo "$s $tpNB subj" >> potential.join
	fi
    fi
    if [[ $(isVar $p) == 1 ]];
    then
	if [[ $(grep $p potential.join | wc -l) == 0 ]];
	then echo "$p $tpNB pred" >> potential.join
	fi
    fi
    if [[ $(isVar $o) == 1 ]];
    then
	if [[ $(grep $o potential.join | wc -l) == 0 ]];
	then echo "$o $tpNB obj" >> potential.join
	fi
    fi
    tpNB=$(( $tpNB + 1 ))
done

# Distinguished Variables
echo "SELECT "
parseDist $(cat $qf | tr ',' ' ') | while read var; do
    echo t$(grep $var potential.join | cut -d' ' -f2,3 | tr ' ' '.')
done | xargs | sed 's/ /, /g'
# Selection.
echo "FROM "
touch potential.clause
tpNB=1
parseBGP $(cat $qf) | while read s p o; do
    if [[ $tpNB == 1 ]];
    then 
	echo "$db.triples AS t1"
	echo $s $p $o >> potential.clause	
    else
	if [[ $(isVar $s) == 1 && $(grep $s potential.join | cut -d' ' -f2) != $tpNB ]];
	then 
	    echo JOIN $db.triples AS t$tpNB ON t$tpNB.subj=t$(grep $s potential.join | cut -d' ' -f2,3 | tr ' ' '.')
	    echo -- $p $o >> potential.clause
	else
	    if [[ $(isVar $p) == 1 && $(grep $p potential.join | cut -d' ' -f2) != $tpNB ]];
	    then 
		echo JOIN $db.triples AS t$tpNB ON t$tpNB.pred=t$(grep $p potential.join | cut -d' ' -f2,3 | tr ' ' '.')
		echo $s -- $o >> potential.clause
	    else
	    	if [[ $(isVar $o) == 1 && $(grep $o potential.join | cut -d' ' -f2) != $tpNB ]];
		then 
		    echo JOIN $db.triples AS t$tpNB ON t$tpNB.obj=t$(grep $o potential.join | cut -d' ' -f2,3 | tr ' ' '.')
		    echo $s $p -- >> potential.clause
		else
		    :
		fi
	    fi  
	fi
    fi
    tpNB=$(( $tpNB + 1 ))
done
# Clauses.
echo "WHERE "
tpNB=1
cat potential.clause | while read s p o; do
    if [[ $(isVar $s) != 1 && $s != "--" ]];
    then echo -e t$tpNB.subj=\'$s\'
    else
	if [[ $(isVar $s) == 1 && $tpNB != $(grep $s potential.join | cut -d' ' -f2) ]];
	then echo t$tpNB.subj=t$(grep $s potential.join | cut -d' ' -f2,3 | tr ' ' '.')
	fi
    fi
    if [[ $(isVar $p) != 1 && $p != "--" ]];
    then echo -e t$tpNB.pred=\'$p\'
    else
	if [[ $(isVar $p) == 1 && $tpNB != $(grep $p potential.join | cut -d' ' -f2) ]];
	then echo t$tpNB.pred=t$(grep $p potential.join | cut -d' ' -f2,3 | tr ' ' '.')
	fi
    fi
    if [[ $(isVar $o) != 1 && $o != "--" ]];
    then echo -e t$tpNB.obj=\'$o\'
    else
	if [[ $(isVar $o) == 1 && $tpNB != $(grep $o potential.join | cut -d' ' -f2) ]];
	then echo t$tpNB.obj=t$(grep $o potential.join | cut -d' ' -f2,3 | tr ' ' '.')
	fi
    fi
    tpNB=$(( $tpNB + 1 ))
done | xargs | sed 's/ / AND /g'

# Cleaning temporary files.
rm potential.join
rm potential.clause

exit 0
