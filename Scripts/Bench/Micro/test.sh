#! /bin/bash

set -v

CBEG=$1
CEND=$2
CMEM=$3
CORE=$(($2-$1 + 1))

docker stop tmicro

docker run --rm -idt --privileged --pid=host --cpuset-cpus=$CBEG-$CEND --memory=${CMEM}GB --memory-swap=-1 --name tmicro micro:v0 /bin/bash

/data/lkf/Effiswap/Perf/retrive_throughput.sh docker exec --user lkf --workdir /home/lkf/mpitest tmicro bash /home/lkf/mpitest/run.sh $CORE

docker stop tmicro