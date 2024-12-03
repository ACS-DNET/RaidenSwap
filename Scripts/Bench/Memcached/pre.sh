#! /bin/bash

CCPU="--cpuset-cpus=0-7 --cpuset-mems=0"
CMEM="--memory=${1:-3.7g}" # MARK

alter() {
    echo -e "\033[33;1m$@\033[0m"
}

alter $CMEM
# 7.4G
docker stop mem_s
docker run $CCPU $CMEM --memory-swap=-1\
         --privileged --rm -idt --pid=host --name mem_s\
         memcached:1.6.25 -m 8192 -p 11211 -l 0.0.0.0