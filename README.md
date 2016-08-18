RDFHive
=======

> Using Apache Hive to directly evaluate SPARQL queries.

__Overview:__ [SPARQL](https://www.w3.org/TR/sparql11-query/) is the
W3C standard query language for querying data expressed in
[RDF](https://www.w3.org/TR/2014/REC-rdf11-concepts-20140225/)
(Resource Description Framework). The increasing amounts of RDF data
available raise a major need and research interest in building
efficient and scalable distributed SPARQL query evaluators.

In this context, we propose and share __RDFHive__: a simple
implementation of a distributed RDF datastore benefiting from Apache
Hive. RDFHive is designed to leverage existing Hadoop infrastructures
for evaluating SPARQL queries. RDFHive relies on a translation of
SPARQL queries into SQL queries that Hive is able to evaluate.

Technically, RDFHive directly evaluates SPARQL queries _i.e._ there is
no preprocessing step, indeed an RDF triple file is seen by Hive as a
three-column table. Thus, the bash translator simply translates SPARQL
queries according to this scheme.

__Version:__ 1.0

Requirements
------------

- [Apache Hadoop](http://hadoop.apache.org) (+HDFS) version __2.6.0-cdh5.7.0__
- [Apache Hive](https://hive.apache.org/) version __1.1.0__

How to use it?
--------------

In this package, we provide sources to load and query RDF datasets
with RDFHive. We also present a simple test-suite based on the popular
RDF/SPARQL benchmark:
[LUBM](http://swat.cse.lehigh.edu/projects/lubm/). For space reasons,
this dataset only contains a few hundred of thousand RDF triples.

### Get the sources.

    git clone github.com/tyrex-team/rdfhive.git ;
    cd rdfhive/ ;

### Load an RDF dataset.

RDFHive can only load RDF data written according to the
[N-Triples](https://www.w3.org/TR/n-triples/) format. This file has to
be uploaded first on the HDFS.

    hadoop fs -copyFromLocal local_file.nt hdfs_file.nt ;
    bash bin/load.sh dbName hdfs_file.nt ;

### Query Evaluation.

To execute a SPARQL query over a loaded RDF dataset, RDFHive first
translates it into SQL and then evaluates the generated query. If
`--debug` is specified, RDFHive will be more verbose.

    bash bin/eval.sh dbName LocalQueryFile ;

### Remove a Database.

An already created database can also be removed.

    bash bin/remove.sh dbName ;

### Test Suite.

Finally, a very basic test suite is included in this repository to
demonstrate RDFHive.

    cd tests/ ;
    bash preliminaries.sh ;
    bash run-benchmarks.sh ;
    bash clean-all.sh ;

### Additional Scripts.

Moreover, two scripts are also part of the project (in bin/):
`lubmqueries.sh` and `watdivqueries.sh` which already contain
translation of [LUBM](http://swat.cse.lehigh.edu/projects/lubm/) and
[WatDiv](http://dsg.uwaterloo.ca/watdiv/) SPARQL queries.

Supported SPARQL Fragment
-------------------------

    digit := [1-9]
    alphanum := [a-z|A-Z|1-9]
    prefix := PREFIX (alphanum)*: <(alphanum)*>
    var := ("?"|"$")(alphanum)*
    tp := (var|(alphanum)*) (var|(alphanum)*) (var|(alphanum)*)
    selectQuery :=
       (prefix)*
       SELECT (REDUCED|DISTINCT)? ("*"|(var)+)
       WHERE { (tp) (" . "tp)* }
       (LIMIT (digit)*)? (OFFSET (digit)*)?

License
-------

This project is under the [CeCILL](http://www.cecill.info/index.en.html) license.

Authors
-------

Damien Graux
<damien.graux@inria.fr>

Pierre Genev&egrave;s
Nabil Laya&iuml;da

[Tyrex Team](tyrex.inria.fr), Inria (France), 2016
