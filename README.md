RDFHive
=======

> Using Apache Hive to evaluate SPARQL queries.

__Overview__: SPARQL is the W3C standard query language for querying
data expressed in the Resource Description Framework (RDF). The
increasing amounts of RDF data available raise a major need and
research interest in building efficient and scalable distributed
SPARQL query evaluators.

In this context, we propose and share RDFHive: a simple implementation
of a distributed RDF datastore benefiting from Apache Hive. RDFHive is
designed to leverage existing Hadoop infrastructures for evaluating
SPARQL queries. RDFHive relies on a translation of SPARQL queries into
SQL queries that Hive is able to evaluate.

__Version__: 1.0

Requirements
------------

- [Apache Hadoop](http://hadoop.apache.org) (+HDFS) version __2.6.0-cdh5.7.0__
- [Apache Hive](https://hive.apache.org/) version __1.1.0__

How to use it?
--------------

In this package, we provide sources to load and query RDF datasets with RDFHive. We also present a simple test-suite based on the popular RDF/SPARQL benchmark: [LUBM](http://swat.cse.lehigh.edu/projects/lubm/). For space reasons, this dataset only contains a few hundred of thousand RDF triples.

__Get the sources__:

    git clone github.com/tyrex-team/rdfhive.git
    cd rdfhive/

__Load an RDF dataset__: RDFHive can only load RDF data written according to the [N-Triples](https://www.w3.org/TR/n-triples/) format. This file has to be uploaded first on the HDFS.

    bash bin/load.sh dbName HDFSFilePath

__Evaluation__: To execute a SPARQL query over a loaded RDF dataset, RDFHive first translates it into SQL and then evaluates the generated query.

    bash bin/eval.sh dbName LocalQueryFile

__Remove__: An already created database can also be removed.

    bash bin/remove.sh dbName

__Test-Suite__: Finally, a very basic test suite is included in this repository to demonstrate RDFHive.

    cd tests/
    bash preliminaries.sh
    bash run-benchmarks.sh
    bash clean-all.sh

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

[Tyrex](tyrex.inria.fr) Team, Inria (France), 2016
