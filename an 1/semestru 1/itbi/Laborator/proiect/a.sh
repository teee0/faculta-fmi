#!/bin/bash

# Helper function to decompress and read logs
decompress_logs() {
    for log in /var/log/auth.log*; do
        if [[ "$log" == *.gz ]]; then
            zcat "$log"
        else
            cat "$log"
        fi
    done
}

# Variables for flags
N_ENTRIES=0
START_DATE=""
END_DATE=""
POINT_DATE=""

# Parse options
while getopts "n:s:t:p:" opt; do
    case $opt in
        n) N_ENTRIES=$OPTARG ;;
        s) START_DATE=$OPTARG ;;
        t) END_DATE=$OPTARG ;;
        p) POINT_DATE=$OPTARG ;;
        *) echo "Invalid option"; exit 1 ;;
    esac
done

# Read and parse logs
logs=$(decompress_logs | grep -E 'sshd\[.*\]: (Accepted|Failed|Invalid)')
decompress_logs
