


#!/bin/sh
# Tester script for assignment 1 and assignment 2
# Author: Siddhant Jajoo

set -e
set -u

NUMFILES=10
WRITESTR=AELD_IS_FUN
WRITEDIR=/tmp/aeld-data
username=$(cat conf/username.txt)

if [ $# -lt 3 ]
then
        echo "Using default value ${WRITESTR} for string to write"
        if [ $# -lt 1 ]
        then
                echo "Using default value ${NUMFILES} for number of files to write"
        else
                NUMFILES=$1
        fi
else
        NUMFILES=$1
        WRITESTR=$2
        WRITEDIR=/tmp/aeld-data/$3
fi

MATCHSTR="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

echo "Writing ${NUMFILES} files containing string ${WRITESTR} to ${WRITEDIR}"

rm -rf "${WRITEDIR}"

# create $WRITEDIR if not assignment1
assignment=$(cat ../conf/assignment.txt)

if [ "$assignment" != 'assignment1' ]
then
        mkdir -p "$WRITEDIR"

        if [ -d "$WRITEDIR" ]
        then
                echo "$WRITEDIR created"
        else
                exit 1
        fi
fi

# Generate files with the specified string
for i in $(seq 1 $NUMFILES)
do
        ./writer.sh "$WRITEDIR/${username}$i.txt" "$WRITESTR"
done

# Call finder.sh to get the output string
OUTPUTSTRING=$(./finder.sh "$WRITEDIR" "$WRITESTR")

# Add functionality to count files and matching lines
num_files=$(find "$WRITEDIR" -type f | wc -l)
num_matching_lines=$(grep -r "$WRITESTR" "$WRITEDIR" 2>/dev/null | wc -l)

# Format and print the result
RESULT="The number of files are $num_files and the number of matching lines are $num_matching_lines"

# Remove temporary directories
rm -rf /tmp/aeld-data

set +e
echo "$OUTPUTSTRING" | grep "${MATCHSTR}"
if [ $? -eq 0 ]; then
        echo "success"
        exit 0
else
        echo "failed: expected ${MATCHSTR} in ${OUTPUTSTRING} but instead found"
        echo "$RESULT" # Output the file and line count result
        exit 1
fi

