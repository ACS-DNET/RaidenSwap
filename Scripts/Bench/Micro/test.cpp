#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fcntl.h>
#include <unistd.h>
#include <assert.h>
#include <stdint.h>
#include <string.h>
#include <sys/mman.h>

using namespace std;

static inline unsigned long long rdtsc(void) {
    unsigned hi, lo;
    __asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
    return ((unsigned long long)lo) | (((unsigned long long)hi) << 32);
}

int main(int args, char* argv[]) {
    MPI_Status status;
    MPI_Init(&args, &argv);

    int rank, size;
    int pid = getpid();
    unsigned long len;

    if (args != 2) {
        cout << "./main access [mem/GB]" << endl;
        return -1;
    } else {
        len = atoi(argv[1]);
    }
    cout << "run access " << len << " GB" << endl;

    len = len * 0x8000000;
    double* arr = (double*)malloc(len * sizeof(double));

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    for (unsigned long c1 = 0; c1 < len; c1 += 512) {
        for (unsigned long c2 = 0; c2 < 512; c2++)
            arr[c1 + c2] = c1 + c2;
    }

    printf("addr %lx ~ %lx \n", (unsigned long)&arr[0], (unsigned long)&arr[len - 1]);
    double sum = 2.0;

    for (unsigned long c1 = 0; c1 < len; c1 += 512) {
        for (unsigned long c2 = 0; c2 < 512; c2++)
            sum += arr[c1 + c2];

        MPI_Barrier(MPI_COMM_WORLD);
    }

    printf("PID: %-6d thread: %-6d sum %6lu\n", pid, rank, ((unsigned long)sum) % 1000);

    MPI_Barrier(MPI_COMM_WORLD);

    if (rank == 0) {
        cout << "continue?" << endl;
        cin >> sum;
    }

    MPI_Barrier(MPI_COMM_WORLD);

    unsigned long long bt = rdtsc();
    sum = 2.0;
    for (unsigned long c1 = 0; c1 < len; c1 += 512) {
        for (unsigned long c2 = 0; c2 < 1; c2++)
            sum += arr[c1 + c2];
    }

    unsigned long long et = rdtsc();
    MPI_Barrier(MPI_COMM_WORLD);
    unsigned long long global_et = rdtsc();

    if (rank == 0) {
        sleep(1);
        printf("PID: %-6d thread: %-6d sum %6lu interval: %-10llu, bw:%.2f Gb/s\n"
               "global br total interval %-16llu, page interval: %-10llu bw: %.2f Gb/s\n",
               pid, rank, ((unsigned long)sum) % 1000, (et - bt), 8 * 2.2 * size * len * sizeof(double) / ((et - bt)),
               (global_et - bt), (global_et - bt) / (len * sizeof(double) / 4096), size * len * 8 * 2.2 * sizeof(double) / ((global_et - bt)));
        cin >> sum;
    } else {
        printf("PID: %-6d thread: %-6d sum %6lu interval: %-10llu, bw:%.2f Gb/s\n",
               pid, rank, ((unsigned long)sum) % 1000, (et - bt), 8 * 2.2 * size * len * sizeof(double) / ((et - bt)));
    }

    MPI_Barrier(MPI_COMM_WORLD);
    free(arr);

    if (rank == 0)
        cout << "finished all, " << sum << endl;

    MPI_Finalize();
    return 0;
}
