#! /bin/bash

echo $#
if [ $# -lt 1 ]; then
    ./bin/ycsb.sh load cassandra-cql -p hosts="172.17.0.2" -threads 4 -p fieldcount=10 -p filedlength=200 -p operationcount=1000000 -p recordcount=1000000 -p requestdistribution=zipfian -P workloads/workloada -s > workloada_load_res.txt
    read -p "press -> continue"
    start_time=$(date +%s)
    ./bin/ycsb.sh run cassandra-cql -p hosts="172.17.0.2" -threads 4 -p fieldcount=10 -p filedlength=200 -p operationcount=1000000 -p recordcount=1000000 -p requestdistribution=zipfian -P workloads/workloada -s  > workloada_run_res.txt
    end_time=$(date +%s)
    cost_time=$[ $end_time-$start_time ]
    echo $cost_time
else
        ./bin/ycsb load cassandra-cql -p hosts="172.17.0.2" -threads 5 -p fieldcount=10 -p filedlength=200 -p operationcount=5000000 -p recordcount=5000000 -p requestdistribution=zipfian -P workloads/workloada -s > workloada_load_res.txt
        ./bin/ycsb run cassandra-cql -p hosts="172.17.0.2" -threads 5 -p fieldcount=10 -p filedlength=200 -p operationcount=5000000 -p recordcount=5000000 -p requestdistribution=zipfian -P workloads/workloada -s  > workloada_run_res.txt
fi