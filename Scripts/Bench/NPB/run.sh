#!/bin/bash

set -v

# docker stop tnpb

# docker run --rm -idt --privileged --pid=host --cpuset-cpus=2-17 --cpuset-mems=0 --memory=12g --memory-swap=-1 --name tnpb npb_test8core:v1 /bin/bash
# docker run --rm -idt --privileged --pid=host --cpuset-cpus=1-4 --cpuset-mems=0 --memory-swap=-1 --name tnpb npb_test8core:v1 /bin/bash
docker run --rm -idt --privileged --pid=host --cpuset-cpus=0-7 --cpuset-mems=0 --memory=4g --memory-swap=-1 --name tnpb npb_test8core:v1 /bin/bash
# docker run --rm -idt --privileged --pid=host --cpuset-cpus=0-1 --cpuset-mems=0 --memory-swap=-1 --name tnpb npb_test8core:v1 /bin/bash
# docker run --rm -idt --privileged --pid=host --cpuset-cpus=2-17 --cpuset-mems=0 --memory-swap=-1 --name tnpb npb_test8core:v1 /bin/bash

# 7G
# docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 4     ./bin/ft.C.x"
docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 8     ./bin/ft.C.x"
# docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 16     ./bin/ft.C.x"

# 26.8G
# docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 8   ./bin/mg.D.x"

# 3.4G
# docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 4   ./bin/mg.C.x"
# docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 8   ./bin/mg.C.x"
# docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 16   ./bin/mg.C.x"


# 24G
# docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 1   ./bin/is.D.x"
# docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 8   ./bin/is.D.x"
# docker exec --user lkf --workdir /home/lkf/NPB3.4.2/NPB3.4-MPI tnpb bash /home/lkf/run.sh "mpirun -np 16   ./bin/is.D.x"

docker stop tnpb