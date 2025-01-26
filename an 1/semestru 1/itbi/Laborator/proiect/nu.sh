#!/bin/bash

# Helper function to decompress and read logs
decompress_logs() {
    for log in /var/log/auth.log*; do
        echo "Reading log: $log"  # Debug output for log files being processed
        if [[ "$log" == *.gz ]]; then
            zcat "$log"  # Decompress and display gzipped logs
        else
            cat "$log"  # Display uncompressed logs
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

# Function to convert date string to timestamp (in seconds)
convert_to_timestamp() {
    date -d "$1" +%s 2>/dev/null || echo 0
}

# Function to simulate the last command
get_login_entries() {
    decompress_logs | grep -E "session opened|session closed|Failed password|Accepted password"
}

# Read login/logout entries
logs=$(get_login_entries)

# Check if logs have been captured correctly
if [[ -z "$logs" ]]; then
    echo "No logs found or filtered logs are empty."
    exit 1
fi

# Debugging output: print the logs to verify capture
echo "Captured logs: $logs"

# Filter by start date (-s)
if [[ -n $START_DATE ]]; then
    start_timestamp=$(convert_to_timestamp "$START_DATE")
    logs=$(echo "$logs" | while read -r line; do
        # Extract date from log line (assuming format 'Mon Jan  5 20:39:57 2025')
        log_timestamp=$(echo "$line" | awk '{print $1, $2, $3, $4}')
        log_timestamp_sec=$(convert_to_timestamp "$log_timestamp")
        if [[ $log_timestamp_sec -ge $start_timestamp ]]; then
            echo "$line"
        fi
    done)
fi

# Filter by end date (-t)
if [[ -n $END_DATE ]]; then
    end_timestamp=$(convert_to_timestamp "$END_DATE")
    logs=$(echo "$logs" | while read -r line; do
        # Extract date from log line
        log_timestamp=$(echo "$line" | awk '{print $1, $2, $3, $4}')
        log_timestamp_sec=$(convert_to_timestamp "$log_timestamp")
        if [[ $log_timestamp_sec -le $end_timestamp ]]; then
            echo "$line"
        fi
    done)
fi

# Filter by point date (-p)
if [[ -n $POINT_DATE ]]; then
    point_timestamp=$(convert_to_timestamp "$POINT_DATE")
    logs=$(echo "$logs" | while read -r line; do
        # Extract date from log line
        log_timestamp=$(echo "$line" | awk '{print $1, $2, $3, $4}')
        log_timestamp_sec=$(convert_to_timestamp "$log_timestamp")
        if [[ $log_timestamp_sec -eq $point_timestamp ]]; then
            echo "$line"
        fi
    done)
fi

# Show the last N entries (-n)
if [[ $N_ENTRIES -gt 0 ]]; then
    logs=$(echo "$logs" | tail -n $N_ENTRIES)
fi

# Output the result
echo "$logs"
