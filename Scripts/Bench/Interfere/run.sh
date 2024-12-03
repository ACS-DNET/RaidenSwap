#! /bin/bash

docker stop mem_s
docker run --cpuset-cpus=12-19 --cpuset-mems=0 --memory=8GB --memory-swap=-1\
        --privileged --rm -idt --pid=host --name mem_s\
        memcached:1.6.25 -m 8192 -p 11211 -l 0.0.0.0
#exit
pushd /home/lkf/ycsb-0.17.0
./memcached.sh &
PID=$!
popd
#exit
RED='\033[0;31m'
NC='\033[0m'
echo ${RED}PID=$PID$NC

copy_log() {
        dirname=$(date +log/%m%d-%H%M%S-$1)
        mkdir -p $dirname
        cp ~/ycsb-0.17.0/workloada_*.txt $dirname/ -f
}

#copy_log no_inter
#exit

while ps -p $PID; do
        # docker stop tmicro
        docker run --rm -idt --privileged --pid=host --cpuset-cpus=0-7 --memory=8GB --memory-swap=-1 --name tmicro micro:v0 /bin/bash
        docker exec --user lkf --workdir /home/lkf/mpitest tmicro bash /home/lkf/mpitest/run.sh 8
done

echo "done"

copy_log inter