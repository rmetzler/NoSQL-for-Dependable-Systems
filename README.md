# NOSQL in Dependable Systems

## Fault Model for very large E-Commerce Websites
performance is key 
shopping cart should always be accessible 
slightest outage has signiﬁcant ﬁnancialconsequences 

• failures are a normal case, not an exception 
• disks failures 
• network partitions 
• data center unavailable 
• what we want: 
• always write, always read 
• even in case of network partition 
• replicate data accross multiple datacenters 


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
