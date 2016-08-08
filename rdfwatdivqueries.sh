#!/bin/bash

if [[ $# != 1 ]];
then
    echo "Usage $0 database_name";
    exit 1;
fi

echo C1
time hive -e "SELECT t1.subj, t4.obj, t6.obj, t7.subj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj JOIN $1.triples AS t5 ON t5.subj=t4.obj JOIN $1.triples AS t6 ON t6.subj=t4.obj JOIN $1.triples AS t7 ON t7.subj=t6.obj JOIN $1.triples AS t8 ON t8.subj=t6.obj WHERE t1.pred='<http://schema.org/caption>' AND t2.pred='<http://schema.org/text>' AND t3.pred='<http://schema.org/contentRating>' AND t4.pred='<http://purl.org/stuff/rev#hasReview>' AND t5.pred='<http://purl.org/stuff/rev#title>' AND t6.pred='<http://purl.org/stuff/rev#reviewer>' AND t7.pred='<http://schema.org/actor>' AND t8.pred='<http://schema.org/language>';" #2> resultats.log

echo C2
time hive -e "SELECT t1.subj, t4.obj, t5.subj, t9.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t2.obj JOIN $1.triples AS t4 ON t4.subj=t3.subj JOIN $1.triples AS t8 ON t8.obj=t4.obj JOIN $1.triples AS t9 ON t9.subj=t8.obj JOIN $1.triples AS t10 ON t10.subj=t9.obj JOIN $1.triples AS t7 ON t7.obj=t8.subj JOIN $1.triples AS t6 ON t6.subj=t7.subj JOIN $1.triples AS t5 ON t5.subj=t6.subj WHERE t1.pred='<http://schema.org/legalName>' AND t2.pred='<http://purl.org/goodrelations/offers>' AND t3.pred='<http://schema.org/eligibleRegion>' AND t3.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Country5>' AND t4.pred='<http://purl.org/goodrelations/includes>' AND t5.pred='<http://schema.org/jobTitle>' AND t6.pred='<http://xmlns.com/foaf/homepage>' AND t7.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/makesPurchase>' AND t8.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/purchaseFor>' AND t9.pred='<http://purl.org/stuff/rev#hasReview>' AND t10.pred='<http://purl.org/stuff/rev#totalVotes>';" #2>> resultats.log

echo C3
time hive -e "SELECT t1.subj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t1.subj=t2.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj JOIN $1.triples AS t5 ON t5.subj=t1.subj JOIN $1.triples AS t6 ON t6.subj=t1.subj WHERE t1.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/likes>' AND t2.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/friendOf>' AND t3.pred='<http://purl.org/dc/terms/Location>' AND t4.pred='<http://xmlns.com/foaf/age>' AND t5.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/gender>' AND t6.pred='<http://xmlns.com/foaf/givenName>';" #2>> resultats.log

echo F1
time hive -e "SELECT t1.subj, t2.obj, t3.subj, t3.obj, t4.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t5 ON t5.obj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t5.subj JOIN $1.triples AS t4 ON t4.subj=t5.subj JOIN $1.triples AS t6 ON t6.subj=t5.subj WHERE t1.pred='<http://ogp.me/ns#tag>' AND t1.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Topic13>' AND t2.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t3.pred='<http://schema.org/trailer>' AND t4.pred='<http://schema.org/keywords>' AND t5.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/hasGenre>' AND t6.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t6.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/ProductCategory2>';" #2>> resultats.log

echo F2
time hive -e "SELECT t1.subj, t1.obj, t2.obj, t4.obj, t5.obj, t6.obj, t7.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj JOIN $1.triples AS t5 ON t5.subj=t1.subj JOIN $1.triples AS t6 ON t6.subj=t1.obj JOIN $1.triples AS t7 ON t7.subj=t1.obj JOIN $1.triples AS t8 ON t8.subj=t1.subj WHERE t1.pred='<http://xmlns.com/foaf/homepage>' AND t2.pred='<http://ogp.me/ns#title>' AND t3.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t4.pred='<http://schema.org/caption>' AND t5.pred='<http://schema.org/description>' AND t6.pred='<http://schema.org/url>' AND t7.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/hits>' AND t8.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/hasGenre>' AND t8.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/SubGenre22>';" #2>> resultats.log

echo F3
time hive -e "SELECT t1.subj, t1.obj, t2.obj, t4.subj, t5.subj, t6.subj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t6 ON t6.obj=t1.subj JOIN $1.triples AS t5 ON t5.subj=t6.subj JOIN $1.triples AS t4 ON t4.obj=t6.subj WHERE t1.pred='<http://schema.org/contentRating>' AND t2.pred='<http://schema.org/contentSize>' AND t3.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/hasGenre>' AND t3.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/SubGenre60>' AND t4.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/makesPurchase>' AND t5.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/purchaseDate>' AND t6.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/purchaseFor>';" #2>> resultats.log

echo F4
time hive -e "SELECT t1.subj, t1.obj, t2.subj, t4.obj, t5.obj, t7.obj, t9.subj, t5.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.obj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj JOIN $1.triples AS t5 ON t5.subj=t1.subj JOIN $1.triples AS t6 ON t6.subj=t1.obj JOIN $1.triples AS t7 ON t7.subj=t1.obj JOIN $1.triples AS t8 ON t8.subj=t1.obj JOIN $1.triples As t9 ON t9.obj=t1.subj WHERE t1.pred='<http://xmlns.com/foaf/homepage>' AND t2.pred='<http://purl.org/goodrelations/includes>' AND t3.pred='<http://ogp.me/ns#tag>' AND t3.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Topic13>' AND t4.pred='<http://schema.org/description>' AND t5.pred='<http://schema.org/contentSize>' AND t6.pred='<http://schema.org/url>' AND t7.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/hits>' AND t8.pred='<http://schema.org/language>' AND t8.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Language0>' AND t9.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/likes>';" #2>> resultats.log

echo F5
time hive -e "SELECT t1.subj, t1.obj, t3.obj, t4.obj, t5.obj, t6.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.obj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj JOIN $1.triples AS t5 ON t5.subj=t1.obj JOIN $1.triples AS t6 ON t6.subj=t1.obj WHERE t1.pred='<http://purl.org/goodrelations/includes>' AND t2.subj='<http://db.uwaterloo.ca/~galuc/wsdbm/Retailer842>' AND t2.pred='<http://purl.org/goodrelations/offers>' AND t3.pred='<http://purl.org/goodrelations/price>' AND t4.pred='<http://purl.org/goodrelations/validThrough>' AND t5.pred='<http://ogp.me/ns#title>' AND t6.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>';" #2>> resultats.log

echo L1
time hive -e "SELECT t1.subj, t2.subj, t2.obj FROM $1.triples AS t3 JOIN $1.triples AS t1 ON t1.subj=t3.subj JOIN $1.triples AS t2 ON t2.subj=t3.obj WHERE t1.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/subscribes>' AND t2.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Website16661>' AND t2.pred='<http://schema.org/caption>' AND t3.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/likes>';" #2>> resultats.log

echo L2
time hive -e "SELECT t1.obj, t2.subj FROM $1.triples AS t3 JOIN $1.triples AS t1 ON t1.obj=t3.obj JOIN $1.triples AS t2 ON t2.subj=t3.subj WHERE t1.subj='<http://db.uwaterloo.ca/~galuc/wsdbm/City13>' AND t1.pred='<http://www.geonames.org/ontology#parentCountry>' AND t2.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/likes>' AND t2.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Product0>' AND t3.pred='<http://schema.org/nationality>';" #2>> resultats.log

echo L3
time hive -e "SELECT t1.subj, t1.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t1.subj=t2.subj WHERE t1.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/likes>' AND t2.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/subscribes>' AND t2.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Website2633>';" #2>> resultats.log

echo L4
time hive -e "SELECT t1.subj, t2.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t1.subj=t2.subj WHERE t1.pred='<http://ogp.me/ns#tag>' AND t1.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Topic96>' AND t2.pred='<http://schema.org/caption>';" #2>> resultats.log

echo L5
time hive -e "SELECT t1.subj, t1.obj, t2.obj FROM $1.triples AS t1 JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t2 ON t2.obj=t3.obj WHERE t1.pred='<http://schema.org/jobTitle>' AND t2.subj='<http://db.uwaterloo.ca/~galuc/wsdbm/City13>' AND t2.pred='<http://www.geonames.org/ontology#parentCountry>' AND t3.pred='<http://schema.org/nationality>';" #2>> resultats.log

echo S1
time hive -e "SELECT t1.subj, t1.obj, t3.obj, t4.obj, t5.obj, t6.obj, t7.obj, t8.obj, t9.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.obj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj JOIN $1.triples AS t5 ON t5.subj=t1.subj JOIN $1.triples AS t6 ON t6.subj=t1.subj JOIN $1.triples AS t7 ON t7.subj=t1.subj JOIN $1.triples AS t8 ON t8.subj=t1.subj JOIN $1.triples AS t9 ON t9.subj=t1.subj WHERE t1.pred='<http://purl.org/goodrelations/includes>' AND t2.subj='<http://db.uwaterloo.ca/~galuc/wsdbm/Retailer633>' AND t2.pred='<http://purl.org/goodrelations/offers>' AND t3.pred='<http://purl.org/goodrelations/price>' AND t4.pred='<http://purl.org/goodrelations/serialNumber>' AND t5.pred='<http://purl.org/goodrelations/validFrom>' AND t6.pred='<http://purl.org/goodrelations/validThrough>' AND t7.pred='<http://schema.org/eligibleQuantity>' AND t8.pred='<http://schema.org/eligibleRegion>' AND t9.pred='<http://schema.org/priceValidUntil>';" #2>> resultats.log

echo S2
time hive -e "SELECT t1.subj, t1.obj, t3.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj WHERE t1.pred='<http://purl.org/dc/terms/Location>' AND t2.pred='<http://schema.org/nationality>' AND t2.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Country8>' AND t3.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/gender>' AND t4.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t4.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Role2>';" #2>> resultats.log

echo S3
time hive -e "SELECT t1.subj, t2.obj, t3.obj, t4.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t3.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/ProductCategory9>' AND t2.pred='<http://schema.org/caption>' AND t3.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/hasGenre>' AND t4.pred='<http://schema.org/publisher>';}" #2>> resultats.log

echo S4
time hive -e "SELECT t1.subj, t2.obj, t3.subj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.obj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj WHERE t1.pred='<http://xmlns.com/foaf/age>' AND t1.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/AgeGroup0>' AND t2.pred='<http://xmlns.com/foaf/familyName>' AND t3.pred='<http://purl.org/ontology/mo/artist>' AND t4.pred='<http://schema.org/nationality>' AND t4.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Country1>';" #2>> resultats.log

echo S5
time hive -e "SELECT t1.subj, t2.obj, t3.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj JOIN $1.triples AS t4 ON t4.subj=t1.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t1.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/ProductCategory3>' AND t2.pred='<http://schema.org/description>' AND t3.pred='<http://schema.org/keywords>' AND t4.pred='<http://schema.org/language>' AND t4.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/Language0>';" #2>> resultats.log

echo S6
time hive -e "SELECT t1.subj, t1.obj, t2.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.subj=t1.subj WHERE t1.pred='<http://purl.org/ontology/mo/conductor>' AND t2.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t3.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/hasGenre>' AND t3.obj='<http://db.uwaterloo.ca/~galuc/wsdbm/SubGenre90>';" #2>> resultats.log

echo S7
time hive -e "SELECT t1.subj, t1.obj, t2.obj FROM $1.triples AS t1 JOIN $1.triples AS t2 ON t2.subj=t1.subj JOIN $1.triples AS t3 ON t3.obj=t1.subj WHERE t1.pred='<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' AND t2.pred='<http://schema.org/text>' AND t3.subj='<http://db.uwaterloo.ca/~galuc/wsdbm/User52828>' AND t3.pred='<http://db.uwaterloo.ca/~galuc/wsdbm/likes>';}" #2>> resultats.log

exit 0;
