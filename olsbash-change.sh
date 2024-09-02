#!/bin/bash

# Date_created: 19/08/2024
# Description: This is a Bash function that takes a file with variables and changes their values with values saved in AWS Systems manager
# Usage:  get-parameters-by-path command with the specified prefix /fakecustomer/ and the input file

replace_with_ssm_parameters() {
    local parameter_prefix=$1
    local input_file=$2

    # Retrieve all parameters under the specified prefix
    parameters=$(aws ssm get-parameters-by-path --path "$parameter_prefix" --with-decryption --query "Parameters" --output json 2>/dev/null)

    if [ $? -ne 0 ]; then
        echo "Failed to retrieve parameters. Check your AWS CLI configuration and permissions."
        exit 1
    fi

    # Loop through each parameter in the JSON and replace its corresponding variable in the file
    keys=$(echo "$parameters" | jq -r '.[].Name' | sed "s|$parameter_prefix||g")

    for key in $keys; do
        # Extract the value for the current key
        parameter_value=$(echo "$parameters" | jq -r --arg key "$key" '.[] | select(.Name == "'$parameter_prefix'" + $key) | .Value // empty')

        # echo "Extracted value for $key: $parameter_value"  # Debug output

        if [ -n "$parameter_value" ]; then
            # Replace the value if the variable exists in the file and starts with a '$'
            sed -i'' -e "s|\\\$$key|$parameter_value|g" "$input_file"
            # echo "Updated value for $key in $input_file"  # Debug output
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

# Call the function with the parameter prefix and input file
#replace_with_ssm_parameters "/fakecustomer/" "/mnt/d/VULTARA/Files/bash_for_var/config.js"
