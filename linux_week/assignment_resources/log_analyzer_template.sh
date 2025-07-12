#!/bin/bash
# Log File Analyzer
# This script analyzes a log file for errors and warnings

# Check if a file was provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

log_file="$1"

# Check if the file exists
if [ ! -f "$log_file" ]; then
    echo "Error: File $log_file does not exist"
    exit 1
fi

# TODO: Analyze the log file for ERROR, WARNING, and INFO messages
# TODO: Count occurrences of each message type
# TODO: Find the 5 most common error messages
# TODO: Find the timestamps of the first and last errors
# TODO: Generate a frequency report by hour

echo "===== LOG FILE ANALYSIS REPORT ====="
echo "File: $log_file"
echo "Analyzed on: $(date)"
echo "Size: $(du -h "$log_file" | cut -f1) ($(wc -c < "$log_file") bytes)"

# HINT: You can use grep, awk, sort, and other text processing commands to analyze the log file
# Example: Count ERROR messages
error_count=$(grep -c "ERROR" "$log_file")
echo -e "\nMESSAGE COUNTS:"
echo "ERROR: $error_count messages"
# TODO: Add counts for WARNING and INFO messages

# Create timestamp for the report file name
timestamp=$(date +"%Y%m%d_%H%M%S")
report_file="log_analysis_${timestamp}.txt"

# TODO: Save the full report to a file
echo "Report saved to: $report_file"
