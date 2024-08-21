#!/bin/bash

# Date_created: 24/07/2024
# Description: This is a Bash function that takes a file with variables and changes their values with values saved in AWS Secrets Manager
# Usage: replace_with_aws_secrets "secret_id" "input_file_path"

replace_with_aws_secrets() {
    local secret_id=$1
    local input_file=$2

    # Retrieve the entire secret JSON
    secret_json=$(aws secretsmanager get-secret-value --secret-id "$secret_id" --query SecretString --output text 2>/dev/null)

    if [ $? -ne 0 ]; then
        echo "Failed to retrieve secret. Check your AWS CLI configuration and permissions."
        exit 1
    fi

    # Loop through each key in the secret JSON and replace its corresponding variable in the file
    keys=$(echo "$secret_json" | jq -r 'keys[]')

    for key in $keys; do
        # Extract the value for the current key
        secret_value=$(echo "$secret_json" | jq -r --arg key "$key" '.[$key] // empty')

        echo "Extracted value for $key: $secret_value"  # Debug output

        if [ -n "$secret_value" ]; then
            # Replace the value if the variable exists in the file and starts with a '$'
            sed -i'' -e "s|\\\$$key|$secret_value|g" "$input_file"
            echo "Updated value for $key in $input_file"  # Debug output
        else
            echo "No corresponding value found in secret for $key; skipping update."
        fi
    done


    # Check if the update operation was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to update $input_file."
        exit 1
    fi
}

# Call the function with the secret ID and input file
replace_with_aws_secrets "fakecustomer" "/mnt/d/VULTARA/Files/bash_for_var/environment.trial.ts"

