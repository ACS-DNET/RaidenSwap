#! /bin/bash

./bin/ycsb load memcached -p memcached.hosts=172.17.0.2:11211 -threads 5 -p fieldcount=10 -p filedlength=200 -p operationcount=5000000 -p recordcount=5000000 -p requestdistribution=zipfian -P workloads/workloada -s > workloada_load_res.txt
./bin/ycsb run memcached -p memcached.hosts=172.17.0.2:11211 -threads 5 -p fieldcount=10 -p filedlength=200 -p operationcount=5000000 -p recordcount=5000000 -p requestdistribution=zipfian -P workloads/workloada -s  > workloada_run_res.txt