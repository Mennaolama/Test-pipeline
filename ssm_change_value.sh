#!/bin/bash

# Date_created: 19/08/2024
# Description: This is a Bash function that takes a file with variables and changes their values with values saved in AWS Systems Manager.
# It takes /app/ and /deployment/ as separate inputs, along with the input file.
# Usage: ./script.sh /app/ /deployment/ /inputfile/

replace_with_ssm_parameters() {
    local app_prefix=$1
    local deployment_prefix=$2
    local input_file=$3

    # Combine app and deployment into the full prefix path
    local full_prefix="${app_prefix}${deployment_prefix}"

    # Retrieve all parameters under the specified prefix
    parameters=$(aws ssm get-parameters-by-path --path "$full_prefix" --with-decryption --query "Parameters" --output json 2>/dev/null)

    if [ $? -ne 0 ]; then
        echo "Failed to retrieve parameters. Check your AWS CLI configuration and permissions."
        exit 1
    fi

    # Loop through each parameter in the JSON and replace its corresponding variable in the file
    keys=$(echo "$parameters" | jq -r '.[].Name' | sed "s|$full_prefix||g")

    for key in $keys; do
        # Extract the value for the current key
        parameter_value=$(echo "$parameters" | jq -r --arg key "$key" '.[] | select(.Name == "'$full_prefix'" + $key) | .Value // empty')

        if [ -n "$parameter_value" ]; then
            # Replace the value if the variable exists in the file and starts with a '$'
            sed -i'' -e "s|\\\$$key|$parameter_value|g" "$input_file"
        else
            echo "No corresponding value found in Parameter Store for $key; skipping update."
        fi
    done

    # Check if the update operation was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to update $input_file."
        exit 1
    fi
}

# Call the function with the provided app, deployment prefix, and input file
replace_with_ssm_parameters "$1" "$2" "$3"
