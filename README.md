# NOSQL in Dependable Systems

__Abstract:__
The fault model for very large e-commerce websites like Amazon is fundamentally different from standard websites. These websites loose money when the aren't available (or just slow) for potential customers but can't risk to loose any data. The data has to be replicated between databases but traditional RDBMSs may not fit.
This paper discusses some of the better known NoSQL software products available today.


__Keywords:__
Fault Tolerance, CAP Theorem, NoSQL, Dynamo, Riak, Cassandra, MongoDB, CouchDB

__Authors:__ 
Richard Metzler [@rmetzler](twitter.com/rmetzler "follow Richard Metzler on Twitter"),
Jan Schütze [@dracoblue](twitter.com/dracoblue "follow Jan Schütze on Twitter")


_TODO:EXPLAIN QUORUMS_

## Fault Model
On very large e-commerce websites like Amazon people order every minute _TODO:WRITE-SOME-FACTS_. Amazon has statistics showing a causal connection between response time of the amazon.com website and the time potential customers spend on the website. _TODO:SOURCE?_
The customer's shopping cart has to be allways accessible for writes and the slightest outage has direct significant financial consequences.

But on the other side failures are the normal case, not an exception. Disks fail, the network experiences partitioning and whole data centers could become potentially unavailable because of natural disasters like hurricanes. 

What our big e-commerce websites need is a datastore that is allways read and write enabled, even in presence of network partitions. Data must be replicated accross multiple datacenters and these datacenters may be located hundreds of kilometers away from each other and even on different continents.


## Replication

_Replication_ is one of the fundamental ideas for fault tolerant systems. But replicating data accross datacenters located several hundreds of kilometers away from each other takes time. Using a traditional RDBMS with ACID style transactions to replicate data in a distributed transaction may be slow and not very scalable. Synchronous atomic updates would not be tolerant towards network partitions.

Asynchronous updates can't be atomic, but they are potentially more resistant in case of network partitioning as these are usually transient faults. 


## Brewer's CAP Theorem

In _TODO:YEAR_ Eric Brewer at this time head of Inktomi _TODO:CHECK_ hold a keynote at _TODO:CONFERENCE_. He presented his idea that was later _BEWIESEN_ in _SOURCE_ stating that atomic data consistency, high availability (~ performance) and network partition tolerance can't be achieved at any given time. This is called the CAP Theorem after the acronym for Consistency, Availability and Partinion tolerance.

Because you can't do anything against network partitions in large networks you have to pick between high availability and data consistency. As stated, large e-commerce websites usually go for high availability and trade consistency for that.

## Eventual Consistent

Werner Vogels, CTO at Amazon, presented in his famous article _TODO:SOURCE_ his idea of data being "Eventual Consistent". By trading ACID's atomicy and consistency for performance and partition tolerance it is possible to increase the responseness _TODO:DOES-THIS-WORD-EXISTS?_ and fault tolerance of websites. The database replications may not be fully consistent but a customer wouldn't usually experience any inconsistencies.

He defined the _inconsistency window_ as „The period between the update and the moment when it is guaranteed that any observer will always see the updated value.“ 


### N / W / R Replica Configuration

Vogels introduces the reader to a short notation for replication configuration for _quorum_ like systems:

+  N = the number of nodes, that store replicas of the data 
+  W = the number of replicas that acknowledge a write operation 
+  R = the number of replicas contacted in a read operation 

With these numbers you are guaranteed _strong consistency_ if following condition holds:

+  N < W + R

This is because the set of replicas for writing and reading the data overlap.

If your replica configuration only holds the condition

+  N >= W + R

it only guaranties weak or eventual consistency.

A RDBMS is typically configured with {N = 2, W = 2, R = 1} while {N = 3, W = 2, R = 2} is a commonly used configuration for fault tolerant systems. 


It is possible to deduce different attributes from these configuration properties.
Consistency ofer all Nodes is reached if W = N .

Read optimized systems will use R = 1 while write optimized systems use W = 1 .

Cassandra is able to run in application speciﬁc N / W / R conﬁguration. This helps Cassandra to recover from transient and permanent failures.

## Products

we installed and ran some simple tests on 

+ Riak 
+ Cassandra 
+ CouchDB 
+ MongoDB 

Disclaimer: very, very simple tests...

### Riak 0.11.0

+ Key-Value Store (Document oriented) 
+ Links 
+ de facto reference implementation of the 
Dynamo paper 
+ created by Basho (ex Akamai), APL 2.0 
+ written in Erlang, HTTP Interface 
+ https://wiki.basho.com/display/RIAK/Riak

#### Replication Config

+ N can vary per bucket 
+ R & W can vary per operation 
+ additional Quorums for 
+ durable writes to disk 
+ deletes


### Cassandra 0.6.3

+ column oriented 
+ created by Facebook, maintained by Apache 
+ inspired by Amazon Dynamo and Google BigTable 
+ written in Java 
+ http://cassandra.apache.org/ 
+ http://wiki.apache.org/cassandra/FrontPage

### MongoDB 1.4.3

+ Key Value Store (Document oriented) 
+ uses custom TCP Protocol (BSON) 
+ written in C++ 
+ created by 10gen, AGPL 
+ http://www.mongodb.org/ 
+ http://www.mongodb.org/display/DOCS/Home 

#### Replication
+ Master/Slave Replication 
+ Replica Pairs 
+ Arbiter decides who is Master (Quorum) 
+ only allowed to write / read from Master 
+ Replica Sets coming soon...

#### crash
+ reindex MongoDB on Crash Fault 
+ may take several hours 
+ increased MTTR

### CouchDB 0.11.0

+ Key Value Store ( Document oriented) 
+ HTTP interface, JSON objects 
+ Apache project 
+ written in Erlang 
+ http://couchdb.apache.org/ 
+ http://wiki.apache.org/couchdb/FrontPage 

## Experiments
+  „Alice“ & „Bob“ 
+  Virtual Box 
+  Debian Squeeze 

### Experiment 1

### Experiment 2

## Sources
+ Eric Brewer: „Towards Robust Distributed Systems“ 
+ Gilbert, Lynch: „Brewer‘s Conjecture and the Feasibility of Consistent, Available, Partition-Tolerant Web Services“
+ Werner Vogels: „Eventual Consistent“ 
+ W.  Vogels et all: „Dynamo:  Amazon‘s highly Available Key-Value Store“ 
+ Lakshman, Malik: „Cassandra - A Decentralized Structured Storage System“ 
