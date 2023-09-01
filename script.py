import yaml

def load_yaml(file_path):
    with open(file_path, 'r') as yaml_file:
        return yaml.safe_load(yaml_file)

def main():
    # Load YAML data from the two files
    yaml_data1 = load_yaml('path/to/first.yaml')
    yaml_data2 = load_yaml('path/to/second.yaml')

    # Extract the names of functions with different isolatedClusters values
    different_function_names = []
    for func1, func2 in zip(yaml_data1['functions'], yaml_data2['functions']):
        if func1.get('isolatedClusters') != func2.get('isolatedClusters'):
            different_function_names.append(func1['name'])

    # Print the function names with different isolatedClusters values
    for name in different_function_names:
        print("Name:", name)

if __name__ == "__main__":
    main()
