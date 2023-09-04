#!/bin/bash

# Define the function to load YAML data
load_yaml() {
    cat "$1" | python3 -c "import sys, yaml; print(yaml.safe_load(sys.stdin))"
}

# Load YAML data from the two files
yaml_data1=$(load_yaml "functions.yaml")
yaml_data2=$(load_yaml "functions2.yaml")

# Extract the names of functions with different isolatedClusters values
different_function_names=()
for ((i=0; i<${#yaml_data1[functions]}; i++)); do
    func1=$(echo "$yaml_data1" | jq -r ".functions[$i]")
    func2=$(echo "$yaml_data2" | jq -r ".functions[$i]")
    if [ "$(echo "$func1" | jq -r .isolatedClusters)" != "$(echo "$func2" | jq -r .isolatedClusters)" ] || \
       [ "$(echo "$func1" | jq -r .colocatedClusters)" != "$(echo "$func2" | jq -r .colocatedClusters)" ] || \
       [ "$(echo "$func1" | jq -r .routingOptions)" != "$(echo "$func2" | jq -r .routingOptions)" ]; then
        different_function_names+=("$(echo "$func1" | jq -r .name)")
    fi
done

# Print the function names with different isolatedClusters, colocatedClusters, or routingOptions values
for name in "${different_function_names[@]}"; do
    echo "Name: $name"
done
