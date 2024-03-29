import yaml
import os

def load_yaml(file_path):
    with open(file_path, 'r') as yaml_file:
        return yaml.safe_load(yaml_file)

def main():
    # Load YAML data from the two files
    main_branch_file = os.environ.get("MAIN_FILE")
    pr_branch_file = os.environ.get("PR_FILE")

    # Extract the filenames from the full paths
    main_branch_filename = os.path.basename(main_branch_file)
    pr_branch_filename = os.path.basename(pr_branch_file)

    # Print the filenames for verification (optional)
    print("Main Branch Filename:", main_branch_filename)
    print("PR Branch Filename:", pr_branch_filename)
    
    main_branch_file = os.environ.get("MAIN_FILE")
    pr_branch_file = os.environ.get("PR_FILE")
    yaml_data1 = load_yaml(main_branch_filename)
    yaml_data2 = load_yaml(pr_branch_filename)

    print(yaml_data1)
    print(yaml_data2)

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
