
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

for name1 in $(echo "$yaml_data1" | jq -r '.functions[].name'); do
    name2=$(echo "$yaml_data2" | jq -r '.functions[] | select(.name == $name1).name')
    if [ "$name1" != "$name2" ]; then
        continue
    fi

    func1=$(echo "$yaml_data1" | jq -r '.functions[] | select(.name == $name1)')
    func2=$(echo "$yaml_data2" | jq -r '.functions[] | select(.name == $name2)')

    if [ \
        "$(echo "$func1" | jq -r '.isolatedClusters')" != "$(echo "$func2" | jq -r '.isolatedClusters')" -o \
        "$(echo "$func1" | jq -r '.colocatedClusters')" != "$(echo "$func2" | jq -r '.colocatedClusters')" -o \
        "$(echo "$func1" | jq -r '.routingOptions')" != "$(echo "$func2" | jq -r '.routingOptions')" \
    ]; then
        different_function_names[$index]="$name1"
        index=$((index+1))
    fi
done

# Print the function names with different properties
for name in "${different_function_names[@]}"; do
    echo "Name: $name"
done
