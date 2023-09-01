#!/bin/bash

# Define the JSON data
json_data='
{
  "functions": [
    {
      "name": "CreateAcount.v1",
      "isolatedClusters": [
        "java-group2"
      ]
    },
    {
      "name": "CreateAcount.v2",
      "isolatedClusters": [
        "java-group3"
      ]
    },
    {
      "name": "CreateAcount.v3",
      "colocatedClusters": [
        "java-group12"
      ],
      "isolatedClusters": [
        "java-group6"
      ]
    },
    {
      "name": "CreateAcount.v4",
      "colocatedClusters": [
        "java-group12"
      ],
      "isolatedClusters": [
        "java-group6",
        "java-group12"
      ]
    },
    {
      "name": "CreateAcount.v5",
      "isolatedClusters": [
        "java-group13"
      ],
      "routingOptions": {
        "mitigatorEnabled": true
      }
    }
  ]
}
'

# Extract the names of functions with changing isolatedClusters values
previous_clusters=""
echo "$json_data" | jq -r '.functions[] | select(.isolatedClusters != $prev) | .name' --arg prev "$previous_clusters" | while read -r name; do
  previous_clusters="$(echo "$json_data" | jq -r --arg name "$name" '.functions[] | select(.name == $name) | .isolatedClusters')"
  echo "Name: $name"
done
