#!/bin/bash

# bash exec.sh init spark_4core:v2
# bash exec.sh init spark_6core:v1
bash exec.sh init spark_8core:v1
# bash exec.sh init spark_10core:v1
#  bash exec.sh init spark_16core:v1
# bash exec.sh init spark_16core_24data:v1

echo "begin run exec $1"

# bfs cc pr
bash exec.sh exec $1

wait

bash exec.sh exit

# run hpl as test app
# bash hpl.sh