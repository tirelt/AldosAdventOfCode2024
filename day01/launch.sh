#!/bin/bash 

measure_time(){
    local program_path="$1"
    local runs="$2"
    local total_time=0
    total_time=0
    for ((i = 1; i <= RUNS; i++)); do
        time_output=$( { time $BINARY_PATH; } 2>&1 | grep real )
        real_time=$(echo $time_output | awk '{print $2}')
        minutes=$(echo $real_time | awk -F'm' '{print $1}') 
        seconds=$(echo $real_time | awk -F'm' '{print $2}' | sed 's/s//') 
        elapsed_ms=$(echo "$minutes * 60000 + $seconds * 1000" | bc -l)
        total_time=$(echo "$total_time + $elapsed_ms" | bc -l)
    done
    average_time=$(echo "$total_time / $runs" | bc -l) 
    echo "$program_path: $average_time ms"
}

RUNS=100

programs=(
    "./theo"
    )

for program in "${programs[@]}"; do 
    measure_time "$program" "$RUNS"
done