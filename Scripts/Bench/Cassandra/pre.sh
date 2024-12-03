#! /bin/bash

set -v
docker stop cas
docker rm cas
# 11.6G
docker run --rm -itd --name cas --cpuset-cpus=0-7 --cpuset-mems=0 --memory=5.8g --memory-swap=-1 my_cas:v0