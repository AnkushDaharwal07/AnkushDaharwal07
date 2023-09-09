#!/bin/bash

# Construct the git diff command with provided SHA values
git_diff_command="git diff $1 $2 -- functions.yaml"

# Run the git diff command and capture the output
diff_output=$($git_diff_command)
echo $diff_output

# Use 'grep' to extract lines starting with '- name:'
name_lines=$(echo "$diff_output" | grep '^- name:')

# Extract -name values using 'cut' and store them in an array
names_array=()
while IFS= read -r line; do
  name=$(echo "$line" | cut -d ' ' -f 3)
  names_array+=("$name")
done <<< "$name_lines"

# Print the list of -name values
echo "[${names_array[*]}]"
