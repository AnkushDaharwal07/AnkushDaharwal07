#!/bin/bash

# Function to extract function names from a YAML file
extract_function_names() {
    grep 'name:' "$1" | awk '{print $2}'
}

# Function to compare two lists of function names
compare_function_names() {
    file1="$1"
    file2="$2"
    
    functions1=($(extract_function_names "$file1"))
    functions2=($(extract_function_names "$file2"))

    for func1 in "${functions1[@]}"; do
        if [[ ! " ${functions2[@]} " =~ " $func1 " ]]; then
            echo "Name: $func1"
        fi
    done
}

# Compare the two YAML files
compare_function_names 'functions.yaml' 'functions2.yaml'
