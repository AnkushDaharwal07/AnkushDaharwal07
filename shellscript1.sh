#!/bin/bash

# Construct the git diff command with provided SHA values
git_diff_command="git diff $1 $2 -- functions.yaml"

# Run the git diff command and capture the output
diff_output=$($git_diff_command)

# Print the git diff output for debugging
echo "Git Diff Output:"
echo "$diff_output"

# Use 'grep' and 'awk' to extract -name values
name_values=$(echo "$diff_output" | grep '^- name:' | awk '{print $3}')

# Print the extracted name values for debugging
echo "Extracted Name Values:"
echo "$name_values"

# Convert the extracted values to a list
names_list=($name_values)

# Print the list of -name values
echo "Final Names List:"
echo "[${names_list[*]}]"
