#!/bin/bash

# Date_created: 19/08/2024
# Description: This Bash function replaces variables in the input file with values saved in AWS Systems Manager.
# It takes /app/ and /deployment/ as separate inputs, along with the input file.
# Usage: source ./replace_with_ssm_parameters.sh /app/ /deployment/ /inputfile/

replace_with_ssm_parameters() {
    local app_prefix=$1
    local deployment_prefix=$2
    local input_file=$3

    # Ensure app_prefix and deployment_prefix have trailing slashes
    app_prefix="${app_prefix%/}/"
    deployment_prefix="${deployment_prefix%/}/"

    # Combine app and deployment into the full prefix path
    local full_prefix="${app_prefix}${deployment_prefix}"

    # Debugging: print the full_prefix to verify correctness
    echo "Fetching parameters from SSM for prefix: $full_prefix"

    # Retrieve all parameters under the specified prefix
    parameters=$(aws ssm get-parameters-by-path --path "$full_prefix" --with-decryption --query "Parameters" --output json 2>/dev/null)

    if [ $? -ne 0 ] || [ -z "$parameters" ]; then
        echo "Failed to retrieve parameters. Check AWS CLI configuration, permissions, and ensure the path exists."
        return 1
    fi

    # Loop through each parameter and replace its corresponding variable in the file
    keys=$(echo "$parameters" | jq -r '.[].Name' | sed "s|$full_prefix||g")

    for key in $keys; do
        # Extract the value for the current key
        parameter_value=$(echo "$parameters" | jq -r --arg key "$key" '.[] | select(.Name == "'$full_prefix'" + $key) | .Value // empty')

        if [ -n "$parameter_value" ]; then
            # Replace the value in the input file where the variable starts with '$'
            sed -i'' -e "s|\\\$$key|$parameter_value|g" "$input_file"
            echo "Replaced $key with $parameter_value in $input_file"
        else
            echo "No corresponding value found in Parameter Store for $key; skipping update."
        fi
    done

    return 0
}

# Call the function with the provided app, deployment prefix, and input file if the script is run directly
# if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
#     replace_with_ssm_parameters "$1" "$2" "$3"
# fi
