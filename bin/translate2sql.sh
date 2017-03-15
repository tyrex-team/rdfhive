#!/bin/bash

db=$1
qf=$2

set -f # Not to expend question mark when echoing variables.

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

# Generating the various parts.
# Potential prefixes first.
touch potential.prefix
parsePrefix $(cat $qf) >> potential.prefix
# Distinguished Variables
dist=$(
    parseDist $(cat $qf | tr ',' ' ' | sed 's/*/JOKER/') | while read var; do
	if [[ $var == "JOKER" ]] ;
	then echo "*" ;
	else echo t$(grep $var potential.join | cut -d' ' -f2,3 | tr ' ' '.') ;
	fi
    done | xargs | sed 's/ /, /g'
)
# Selection.
touch potential.clause
tpNB=1
from=$(
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
			# :
			# Cartesian ... :(
			echo , $db.triples AS t$tpNB
			echo $s $p $o >> potential.clause
		    fi
		fi  
	    fi
	fi
	tpNB=$(( $tpNB + 1 ))
    done
)
# Clauses.
tpNB=1
where=$(
    cat potential.clause | while read s p o; do
	if [[ $(isVar $s) != 1 && $s != "--" ]];
	then echo -e "t$tpNB.subj=\'$(replaceWithPrefix potential.prefix $s)\'"
	else
	    if [[ $(isVar $s) == 1 && $tpNB != $(grep $s potential.join | cut -d' ' -f2) ]];
	    then echo t$tpNB.subj=t$(grep $s potential.join | cut -d' ' -f2,3 | tr ' ' '.')
	    fi
	fi
	if [[ $(isVar $p) != 1 && $p != "--" ]];
	then echo -e "t$tpNB.pred=\'$(replaceWithPrefix potential.prefix $p)\'"
	else
	    if [[ $(isVar $p) == 1 && $tpNB != $(grep $p potential.join | cut -d' ' -f2) ]];
	    then echo t$tpNB.pred=t$(grep $p potential.join | cut -d' ' -f2,3 | tr ' ' '.')
	    fi
	fi
	if [[ $(isVar $o) != 1 && $o != "--" ]];
	then echo -e "t$tpNB.obj=\'$(replaceWithPrefix potential.prefix $o)\'"
	else
	    if [[ $(isVar $o) == 1 && $tpNB != $(grep $o potential.join | cut -d' ' -f2) ]];
	    then echo t$tpNB.obj=t$(grep $o potential.join | cut -d' ' -f2,3 | tr ' ' '.')
	    fi
	fi
	tpNB=$(( $tpNB + 1 ))
    done | xargs | sed 's/ / AND /g'
)

# Printing final SQL query.
source potential.modifier
if [[ $distinctFlag == 1 ]];
then echo "SELECT DISTINCT ";
else echo "SELECT ";
fi
echo $dist
echo "FROM "
echo $from
if [[ $where != "" ]] ;
then 
    echo "WHERE "
    echo $where
fi
echo $(parseModifiers $(cat $qf))

# Cleaning temporary files.
rm potential.prefix
rm potential.modifier
rm potential.join
rm potential.clause

#
set +f

exit 0
