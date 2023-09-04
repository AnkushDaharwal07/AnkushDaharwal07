#!/bin/bash

# Load YAML data from the two files
yaml_data1=$(yq e '.functions' 'functions.yaml')
yaml_data2=$(yq e '.functions' 'functions2.yaml')

# Extract the names of functions with different isolatedClusters values
different_function_names=()

# Loop through the functions in the first file
while IFS= read -r func1; do
    # Get the name of the function
    name=$(echo "$func1" | yq e '.name' -)

    # Check if there is a function with the same name in the second file
    func2=$(echo "$yaml_data2" | yq e "map(select(.name == \"$name\")) | .[0]" -)
    if [[ -n "$func2" ]]; then
        # Compare the isolatedClusters, colocatedClusters, and routingOptions values
        if [[ "$(echo "$func1" | yq e '.isolatedClusters' -)" != "$(echo "$func2" | yq e '.isolatedClusters' -)" ]] ||
           [[ "$(echo "$func1" | yq e '.colocatedClusters' -)" != "$(echo "$func2" | yq e '.colocatedClusters' -)" ]] ||
           [[ "$(echo "$func1" | yq e '.routingOptions' -)" != "$(echo "$func2" | yq e '.routingOptions' -)" ]]; then
            # Add the function name to the list of different function names
            different_function_names+=("$name")
        fi
    fi
done < <(echo "$yaml_data1")

# Print the function names with different isolatedClusters, colocatedClusters, or routingOptions values
for name in "${different_function_names[@]}"; do
    echo "Name: $name"
done
