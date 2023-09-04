#!/bin/bash

# Function to load YAML data from a file
load_yaml() {
    file_path="$1"
    yq eval ' .' "$file_path"
}

# Load YAML data from the two files
yaml_data1=$(load_yaml 'functions.yaml')
yaml_data2=$(load_yaml 'functions2.yaml')

# Extract the names of functions with different isolatedClusters values
different_function_names=()
index=0

# Iterate through the function names in yaml_data1
for name in $(echo "$yaml_data1" | jq -r '.functions[].name'); do
    # Check if the same name exists in yaml_data2 with different properties
    if ! echo "$yaml_data2" | jq -e --arg name "$name" \
        '.functions[] | select(.name == $name and (.isolatedClusters != input.functions[] | select(.name == $name).isolatedClusters or
        .colocatedClusters != input.functions[] | select(.name == $name).colocatedClusters or
        .routingOptions != input.functions[] | select(.name == $name).routingOptions))' >/dev/null; then
        different_function_names[$index]=$name
        index=$((index+1))
    fi
done

# Print the function names with different properties
for name in "${different_function_names[@]}"; do
    echo "Name: $name"
done
