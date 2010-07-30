# NOSQL in Dependable Systems

__Abstract:__
The fault model for very large e-commerce websites like Amazon is fundamentally different from standard website. These websites loose money when the aren't available (or just slow) for potential customers but can't risk to loose any data. The data has to be replicated between databases but traditional RDBMSs may not fit.
This paper discusses some of the better known NoSQL software products available today.


__Keywords:__
Fault Tolerance, CAP Theorem, NoSQL, Dynamo, Riak, Cassandra, MongoDB, CouchDB

__Authors:__ 
Richard Metzler @rmetzler, Jan Schütze @dracoblue




## Fault Model for very large E-Commerce Websites
On very large e-commerce websites like Amazon people order every minute _TODO:WRITE-SOME-FACTS_. Amazon has statistics showing a causal connection between response time of the amazon.com website and the time potential customers spend on the website. _TODO:SOURCE?_
The customer's shopping cart has to be allways accessible for writes and the slightest outage has direct significant financial consequences.

But on the other side failures are the normal case, not an exception. Disks fail, the network experiences partitioning and whole data centers could become potentially unavailable because of natural disasters like hurricanes. 

What our big e-commerce websites need is a datastore that is allways read and write enabled, even in presence of network partitions. Data must be replicated accross multiple datacenters and these datacenters may be located hundreds of kilometers away from each other and even on different continents.


## Replication
async Message ~ not atomic 
•sync Message ~ not partition tolerant, slow 

## Brewer's CAP Theorem

Consistency - Partition - Tolerance 


• Atomic Data Consistency 
• High Availability (aka Performance) 
• Network Partition tolerant 
•only two of these can be achieved at any given timeAvailability 


## Eventual Consistent

Tradeoff: 
• give up ACID‘s Atomicy and Consistency 
• get Performance and Partition Tolerance 
• Inconsistency Window: 
• „The period between the update and the 
moment when it is guaranteed that any 
observer will always see the updated value.“ 


### N / W / R

• N - number of nodes, that store replicas of data 
• W - number of replicas that acknowledge a write operation 
• R - number of replicas contacted in a read operation 
• Consistency Guarantees 
• N < W+R ~ strong consistency 
• N >= W+R ~ weak / eventual consistency 

•Conﬁguration Properties 
•RDBMS: N = 2, W = 2, R = 1 
•fault tolerant: N = 3, W = 2, R = 2 
•consistency:  W = N 
•read optimized: R = 1 
•write optimized: W = 1

• application speciﬁc     
N / W / R conﬁguration 
• recovery from transient 
and permanent failure

## Products

•we installed and ran some simple tests on 
•Riak 
•Cassandra 
•CouchDB 
•MongoDB 
•Disclaimer: very, very simple tests...

### Riak 0.11.0

•Key-Value Store (Document oriented) 
+ Links 
•de facto reference implementation of the 
Dynamo paper 
•created by Basho (ex Akamai), APL 2.0 
•written in Erlang, HTTP Interface 
•https://wiki.basho.com/display/RIAK/Riak

#### Replication Config

•N can vary per bucket 
•R & W can vary per operation 
•additional Quorums for 
•durable writes to disk 
•deletes


### Cassandra 0.6.3
column oriented 
•created by Facebook, maintained by Apache 
•inspired by Amazon Dynamo and Google BigTable 
•written in Java 
•http://cassandra.apache.org/ 
•http://wiki.apache.org/cassandra/FrontPage

### MongoDB 1.4.3

Key Value Store (Document oriented) 
•uses custom TCP Protocol (BSON) 
•written in C++ 
•created by 10gen, AGPL 
•http://www.mongodb.org/ 
•http://www.mongodb.org/display/DOCS/ 
Home 

#### Replication
•Master/Slave Replication 
•Replica Pairs 
•Arbiter decides who is Master (Quorum) 
•only allowed to write / read from Master 
•Replica Sets coming soon...

#### crash
•reindex MongoDB on Crash Fault 
•may take several hours 
•increased MTTR

### CouchDB 0.11.0

•Key Value Store ( Document oriented) 
•HTTP interface, JSON objects 
•Apache project 
•written in Erlang 
•http://couchdb.apache.org/ 
•http://wiki.apache.org/couchdb/FrontPage 

## Experiments
• „Alice“ & „Bob“ 
• Virtual Box 
• Debian Squeeze 

### Experiment 1

### Experiment 2

## Sources
• Eric Brewer: „Towards Robust Distributed Systems“ 
• Gilbert, Lynch: „Brewer‘s Conjecture and the Feasibility of Consistent, Available, Partition-Tolerant Web Services“ 
• Werner Vogels: „Eventual Consistent“ 
• W.  Vogels et all: „Dynamo:  Amazon‘s highly Available Key-Value Store“ 
• Lakshman, Malik: „Cassandra - A Decentralized Structured Storage System“ 
