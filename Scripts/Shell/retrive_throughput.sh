#! /bin/bash

IB=$1

perf_ib () {
         sudo ibqueryerrors --counters -G $IB -K
}

if (( $# >= 1 )); then
        perf_ib
        "$@"
        perf_ib
else
        perf_ib
fi