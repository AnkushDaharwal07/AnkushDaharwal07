#!/bin/bash

# Function to load YAML data from a file
load_yaml() {
    file_path="$1"
    cat "$file_path" | yq eval -P
}

# Load YAML data from the two files
yaml_data1=$(load_yaml 'functions.yaml')
yaml_data2=$(load_yaml 'functions2.yaml')

# Extract the names of functions with different isolatedClusters values
different_function_names=()
index=0
for i in $(jq -c -n "$yaml_data1 $yaml_data2 | .functions[] as \$f1 | .functions[] as \$f2 | select(\$f1 != \$f2) | \$f1.name"); do
    different_function_names[$index]=$i
    index=$((index+1))
done

# Print the function names with different isolatedClusters, colocatedClusters, or routingOptions values
for name in "${different_function_names[@]}"; do
    echo "Name: $name"
done
