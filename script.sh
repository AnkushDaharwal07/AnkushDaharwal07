#!/bin/bash

# Convert YAML files to JSON
json_data1=$(cat functions.yaml | yq eval -j)
json_data2=$(cat functions.yaml | yq eval -j)

IFS=$'\n' read -d '' -r -a names <<< "$(jq -r '.functions[] | select(.isolatedClusters != ($prev | fromjson)) | .name' --argjson prev "$json_data1" <<< "$json_data2"$'\x00')"

for name in "${names[@]}"; do
  echo "Name: $name"
done
