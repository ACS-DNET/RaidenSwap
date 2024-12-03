#! /bin/bash

pushd /sys/kernel/debug/tracing
echo 0 > tracing_on
echo function > current_tracer
echo blk_update_request > set_ftrace_filter

popd