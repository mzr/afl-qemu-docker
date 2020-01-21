#!/usr/bin/bash

echo core | sudo tee /proc/sys/kernel/core_pattern > /dev/null && \
docker run -it --rm \
    -e AFL_SKIP_CPUFREQ='1' \
    $* \
    afl-qemu

echo "|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %e" \
    | sudo tee /proc/sys/kernel/core_pattern > /dev/null
