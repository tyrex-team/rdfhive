
echo "distinctFlag=0" >> potential.modifier

function parseDist {
    flag=0
    shopt -s nocasematch
    while true; do
	case "$1" in
	    "select" ) flag=1; shift ;;
	    "reduced" ) shift ;; # Ignored.
	    "distinct" ) echo "distinctFlag=1" >> potential.modifier ; shift ;;
	    "" | "where" | "where{" ) break ;;
	    * )
		if [[ $flag == 0 ]];
		then shift
		else echo $1; shift
		fi
		;;
	esac
    done
    shopt -u nocasematch
}
function parseBGP {
    flag=0
    shopt -s nocasematch
    while true; do
	case "$1" in
	    "where" | "where{" )
		flag=1
		shift
		;;
	    "{" ) shift ;;
	    "" | "}" ) break ;;
	    * )
		if [[ $flag == 0 ]];
		then shift
		else 
		    # Warn: Strings as objects are currently NOT handled!
		    echo -e $1 $2 $3
		    if [[ $4 == "." ]];
		    then shift 4
		    else shift 3
		    fi
		fi
		;;
	esac
    done
    shopt -u nocasematch
}
function parseModifiers {
    flag=0
    shopt -s nocasematch
    while true; do
	case "$1" in
	    "}" ) flag=1; shift ;;
	    "limit" ) if [[ $flag == 1 ]]; then echo "LIMIT $2"; fi ; shift 2 ;;
	    "offset" ) shift 2 ;; # Ignored.
	    "" ) break ;;
	    * ) if [[ $flag == 1 ]]; then break ; else shift ; fi ;;
	esac
    done
    shopt -u nocasematch
}
function parsePrefix {
    shopt -s nocasematch
    while true; do
	case "$1" in
	    "prefix" )
		echo "$(echo $2 | sed 's/://g') $(echo $3 | sed 's/[<>]//g')"
		shift 3
		;;
	    "" ) break ;;
	    * ) shift ;;
	esac
    done
    shopt -u nocasematch
}
function replaceWithPrefix {
    prefixFile=$1
    word=$2
    if [[ ${word:0:1} == "<" ]];
    then echo $word
    else
	pref=$(echo $word | cut -d':' -f1)
	if [[ $pref == $word ]];
	then echo $word
	else
	    realuri=$(grep $pref $prefixFile | head -n 1 | cut -d' ' -f2)
	    if [[ $realuri == "" ]];
	    then echo $word
	    else
		value=$(echo $word | cut -d':' -f2)
		echo "<"$realuri$value">"
	    fi
	fi
    fi
}
function isVar {
    str1=$1
    if [[ ${str1:0:1} == +("?"|"\$") ]] ; 
    then echo 1 ; 
    else echo 0 ;
    fi
}
