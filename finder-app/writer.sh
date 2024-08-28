#!/bin/bash

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Error: Please provide exactly two arguments."
    echo "Format: $0 <file> <str>"
    exit 1
fi

file=$1
str=$2

# Get the directory path from the file argument
pathdir=$(dirname "${file}")

# Create the directory if it doesn't exist
if ! mkdir -p "${pathdir}"; then
    echo "Error: Cannot create directory path: ${pathdir}."
    exit 1
fi

# Write the string to the file
if ! echo "${str}" > "${file}"; then
    echo "Error: Cannot write to file: ${file}."
    exit 1
fi

echo "Successfully wrote to ${file}"

exit 0
