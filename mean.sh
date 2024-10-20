#!/bin/bash

# Check if the correct number of arguments is provided
if [[ $# -lt 1 || $# -gt 2 ]]; then
    echo "Usage: $0 <column> [file.csv]" 1>&2
    exit 1
fi

# Assign the column and file variables
column=$1
file=${2:-/dev/stdin}  # Default to stdin if no file is provided

# Check if the column is a valid number
if ! [[ $column =~ ^[0-9]+$ ]]; then
    echo "Error: <column> must be a valid number." 1>&2
    exit 1
fi

# Extract the specified column, skip the header, and calculate the mean
cut -d, -f"$column" "$file" | tail -n +2 | {
    sum=0
    count=0
    while read value; do
        # Ensure that the value is numeric before processing
        if [[ $value =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
            sum=$(echo "$sum + $value" | bc)
            count=$((count + 1))
        fi
    done
    if [[ $count -eq 0 ]]; then
        echo "No valid numeric data found in column $column" 1>&2
        exit 1
    else
        mean=$(echo "scale=2; $sum / $count" | bc)
        echo "Mean of column $column: $mean"
    fi
}
