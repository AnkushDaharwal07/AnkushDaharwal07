import yaml
import os

def load_yaml(file_path):
    with open(file_path, 'r') as yaml_file:
        return yaml.safe_load(yaml_file)

def main():
    # Load YAML data from the two files
    main_branch_file = os.environ.get("MAIN_FILE")
    pr_branch_file = os.environ.get("PR_FILE")
    yaml_data1 = load_yaml(main_branch_file)
    yaml_data2 = load_yaml(pr_branch_file)

    # Extract the names of functions with different isolatedClusters values
    different_function_names = []
    for func1, func2 in zip(yaml_data1['functions'], yaml_data2['functions']):
        if (
            func1.get('isolatedClusters') != func2.get('isolatedClusters') or
            func1.get('colocatedClusters') != func2.get('colocatedClusters') or
            func1.get('routingOptions') != func2.get('routingOptions')
        ):
            different_function_names.append(func1['name'])

    # Print the function names with different isolatedClusters, colocatedClusters, or routingOptions values
    for name in different_function_names:
        print("Name:", name)

if __name__ == "__main__":
    main()
