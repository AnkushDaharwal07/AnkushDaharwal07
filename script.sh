#!/bin/bash

# Convert YAML files to JSON
json_data1=$(cat functions.yaml | yq eval -j)
json_data2=$(cat functions.yaml | yq eval -j)

# Extract the names of functions with changing isolatedClusters values
previous_clusters=""
echo "$json_data1" | jq -r '.functions[] | select(.isolatedClusters != $prev) | .name' --arg prev "$previous_clusters" | while read -r name; do
  previous_clusters="$(echo "$json_data1" | jq -r --arg name "$name" '.functions[] | select(.name == $name) | .isolatedClusters')"
  echo "Name: $name"
done

# Repeat for json_data2

# Compare json_data1 and json_data2
if [ "$json_data1" != "$json_data2" ]; then
  echo "JSON data has changed between the two YAML files."
fi
