import yaml
import os

def load_yaml(file_path):
    with open(file_path, 'r') as yaml_file:
        return yaml.safe_load(yaml_file)

def main():
    main_branch_file = sys.argv[1]
    pr_branch_file = sys.argv[2]

    main_yaml = load_yaml(main_branch_file)
    pr_yaml = load_yaml(pr_branch_file)
        # Extract the names of functions with different isolatedClusters values
        different_function_names = []
        for func1, func2 in zip(main_yaml['functions'], pr_yaml['functions']):
            if (
                func1.get('isolatedClusters') != func2.get('isolatedClusters') or
                func1.get('colocatedClusters') != func2.get('colocatedClusters') or
                func1.get('routingOptions') != func2.get('routingOptions')
            ):
                different_function_names.append(func1['name'])

        # Print the function names with different isolatedClusters, colocatedClusters, or routingOptions values
        for name in different_function_names:
            print("Name:", name)

        output_filename = "functions.txt"

        with open(output_filename, "w") as output_file:
            for name in different_function_names:
                output_file.write(name + "\n")
    else:
        print("Environment variables not set properly.")

if __name__ == "__main__":
    if not os.path.exists("functions.txt"):
        with open("functions.txt", "w"):
            pass  # Create the file if it doesn't exist
    main()
