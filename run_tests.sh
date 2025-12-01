#!/bin/bash

echo "===================="
echo "Running Tests"
echo "===================="

mkdir -p output_files

if [ ! -f bin/interrupts_EP ]; then
    echo "Error: schedulers not built. Run ./build.sh"
    exit 1
fi

echo ""
echo "Running EP, RR, EP+RR on 22 tests..."
echo ""

for sched in EP RR EP_RR; do
    echo "Scheduler: $sched"
    echo "---------------------"
    for i in $(seq 1 22); do
        if [ -f input_files/test$i.txt ]; then
            echo "Running test $i..."
            ./bin/interrupts_$sched input_files/test$i.txt > /dev/null 2>&1
            mv execution.txt output_files/execution_${sched}_test${i}.txt
        fi
    done
    echo ""
done

echo ""
echo "All test output stored in output_files/"
