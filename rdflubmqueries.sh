#!/bin/bash

if [[ $# != 1 ]];
then
    echo "Usage $0 database_name";
    exit 1;
fi

echo Q1
#time hive -e "SELECT t1.subj  FROM $1.triples AS t1      JOIN $1.triples AS t2 ON t2.subj=t1.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#GraduateStudent>' AND t2.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#takesCourse>' AND t2.obj='<http://www.Department0.University0.edu/GraduateCourse0>';" 2> logs

#echo Q2
#time hive -e "SELECT t1.subj, t2.subj, t3.subj FROM $1.triples AS t1, $1.triples AS t2,  $1.triples AS t3     JOIN $1.triples AS t4 ON t4.subj=t1.subj     JOIN $1.triples AS t5 ON t5.subj=t3.subj     JOIN $1.triples AS t6 ON t6.subj=t1.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#GraduateStudent>' AND t2.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t2.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#University>' AND t3.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t3.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Department>' AND t4.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#memberOf>' AND t4.obj=t3.subj AND t5.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#subOrganizationOf>' AND t5.obj=t2.subj AND t6.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#undergraduateDegreeFrom>' AND t6.obj=t2.subj ;" 2> logs

echo Q3
#time hive -e "SELECT t1.subj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t1.subj=t2.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Publication>' AND t2.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#publicationAuthor>' AND t2.obj='<http://www.Department0.University0.edu/AssistantProfessor0>' ;" 2> logs

echo Q4
#time hive -e "SELECT t1.subj, t3.obj, t4.obj, t5.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 on t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj JOIN $1.triples AS t5 ON t5.subj=t1.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Professor>' AND t2.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#worksFor>' AND t2.obj='<http://www.Department0.University0.edu>' AND t3.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#name>' AND t4.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#emailAddress>' AND t5.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#telephone>' ;" 2> logs

echo Q5
#time hive -e "SELECT t1.subj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t1.subj=t2.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Person>' AND t2.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#memberOf>' AND t2.obj='<http://www.Department0.University0.edu>' ;" 2> logs

echo Q6
#time hive -e "SELECT t1.subj FROM $1.triples AS t1 WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Student>' ;" 2> logs

echo Q7
#time hive -e "SELECT t1.subj, t2.subj FROM $1.triples AS t1, $1.triples AS t2 JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.obj=t2.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Student>' AND t2.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t2.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Course>' AND t3.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#takesCourse>' AND t3.obj=t2.subj AND t4.subj='<http://www.Department0.University0.edu/AssociateProfessor0>' AND t4.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#teacherOf>' ;" 2> logs

echo Q8
time hive -e "SELECT t1.subj, t2.subj, t5.obj FROM $1.triples AS t1, $1.triples AS t2 JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t2.subj JOIN $1.triples AS t5 ON t5.subj=t1.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Student>' AND t2.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t2.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Department>' AND t3.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#memberOf>' AND t3.obj=t2.subj AND t4.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#subOrganizationOf>' AND t4.obj='<http://www.University0.edu>' AND t5.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#emailAddress>' ;" 2> logs

echo Q9
time hive -e "SELECT t1.subj, t2.subj, t3.subj FROM $1.triples AS t1, $1.triples AS t2,  $1.triples AS t3     JOIN $1.triples AS t4 ON t4.subj=t1.subj     JOIN $1.triples AS t5 ON t5.subj=t2.subj     JOIN $1.triples AS t6 ON t6.subj=t1.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Student>' AND t2.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t2.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Faculty>' AND t3.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t3.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Course>' AND t4.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#advisor>' AND t4.obj=t2.subj AND t5.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#teacherOf>' AND t5.obj=t3.subj AND t6.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#takesCourse>' AND t6.obj=t3.subj ;" 2> logs

echo Q10
time hive -e "SELECT t1.subj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t1.subj=t2.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Student>' AND t2.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#takesCourse>' AND t2.obj='<http://www.Department0.University0.edu/GraduateCourse0>' ;" 2> logs

echo Q11
time hive -e "SELECT t1.subj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t1.subj=t2.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#ResearchGroup>' AND t2.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#subOrganizationOf>' AND t2.obj='<http://www.University0.edu>' ;" 2> logs

echo Q12
time hive -e "SELECT t1.subj, t2.subj FROM $1.triples AS t1, $1.triples AS t2 JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t2.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Chair>' AND t2.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t2.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Department>' AND t3.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#worksFor>' AND t3.obj=t2.subj AND t4.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#subOrganizationOf>' AND t4.obj='<http://www.University0.edu>' ;" 2> logs

echo Q13
time hive -e "SELECT t1.subj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.obj=t1.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#Person>' AND t2.subj='<http://www.University0.edu>' AND t2.pred='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#hasAlumnus>' ;" 2> logs

echo Q14
#time hive -e "SELECT t1.subj FROM $1.triples AS t1 WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://www.lehigh.edu/~zhp2/2004/0401/univ-bench.owl#UndergraduateStudent>' ;" 2> logs

exit 0;
