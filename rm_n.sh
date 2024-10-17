#!/bin/bash

# Check if the correct number of arguments is provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <dir> <n>" 1>&2
    exit 1
fi

# Assign arguments to variables
dir=$1
n=$2

# Check if the directory exists
if [[ ! -d "$dir" ]]; then
    echo "Error: Directory $dir does not exist." 1>&2
    exit 1
fi

# Check if the second argument is a valid number
if ! [[ $n =~ ^[0-9]+$ ]]; then
    echo "Error: $n is not a valid number." 1>&2
    exit 1
fi

# Find and remove files larger than n bytes in the directory
find "$dir" -type f -size +"${n}c" -exec rm {} \;
