#!/bin/bash

# Construct the git diff command with provided SHA values
git_diff_command="git diff $1 $2 -- functions.yaml"

# Run the git diff command and capture the output
diff_output=$($git_diff_command)
echo $diff_output

# Use 'awk' to extract - name values
name_values=$(echo "$diff_output" | awk '/^- name:/ {print $3}')

# Convert the extracted values to a list
names_list=($name_values)

# Print the list of - name values
echo "[${names_list[*]}]"
