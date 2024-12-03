#!/bin/bash

CCMD=$1
CONTAINER=$2
APP=$2
# bfs pr cc lp tc
# APP=bfs
# APP=pr
# APP=cc
# could not work
# APP=lp
# APP=tc

if [[ ${CCMD} == "init" ]]
then
    echo "init"
    docker stop tspark

    # docker run --rm -idt --privileged --pid=host --cpuset-cpus=0-3 --cpuset-mems=0 --memory-swap=-1 --name tspark $CONTAINER /bin/bash
    docker run --rm -idt --privileged --pid=host --cpuset-cpus=1-8 --cpuset-mems=0 --memory=14g --memory-swap=-1 --name tspark $CONTAINER /bin/bash
    # docker run --rm -idt --privileged --pid=host --cpuset-cpus=2-17 --memory=8g --memory-swap=-1 --name tspark $CONTAINER /bin/bash
    # docker run --rm -idt --privileged --pid=host --cpuset-cpus=2-17 --cpuset-mems=0 --memory=19g --memory-swap=-1 --name tspark $CONTAINER /bin/bash


    # docker run --rm -it --privileged --pid=host --cpuset-cpus=2-17 --name tspark $CONTAINER /bin/bash

    docker exec --user lkf --workdir /home/lkf/spark/BB_V5.0_Graph/Spark-Graphx/ tspark bash start_env.sh
    # docker exec --workdir /data/lkf/spark/BB_V5.0_Graph/Spark-Graphx/ tspark bash start_env.sh

elif [[ ${CCMD} == "exec" ]]
then
    echo "exec"
    docker exec --user lkf --workdir /home/lkf/spark/BB_V5.0_Graph/Spark-Graphx/ tspark bash im_run_graph.sh ${APP}
    # docker exec --workdir /data/lkf/spark/BB_V5.0_Graph/Spark-Graphx/ tspark bash im_run_graph.sh ${APP}
else
    echo "exit"
    docker stop tspark
fi