#! /bin/bash

FILE_NAME="test.cpp"

docker stop tmicro
docker run --user lkf --rm -idt --cpuset-cpus=0-3 --memory=8g --memory-swap=-1 --name micro:v0 /bin/bash
docker cp $FILE_NAME tmicro:/home/lkf/
echo 0 > /proc/kp_refault
docker exec --user lkf -w /home/lkf -it tmicro /bin/bash -c "g++ $FILE_NAME -lpthread && ./a.out"
echo 1 > /proc/kp_refault