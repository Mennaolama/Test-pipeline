#!/bin/bash

# Function to retrieve a specific variable from a given secret name
get_secret_variable() {
  local SECRET_NAME=$1
  local VARIABLE_NAME=$2

  # Retrieve the secret value from AWS Secrets Manager
  SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id "$SECRET_NAME" --query SecretString --output text 2>/dev/null)
  
  if [ $? -ne 0 ]; then
    echo "Error: Unable to retrieve secret. Make sure the secret name '$SECRET_NAME' is correct and you have the necessary permissions."
    exit 1
  fi

  # Extract the specified variable from the secret value using jq
  VARIABLE_VALUE=$(echo $SECRET_VALUE | jq -r --arg var "$VARIABLE_NAME" '.[$var]')

  if [ "$VARIABLE_VALUE" == "null" ]; then
    echo "Error: Variable '$VARIABLE_NAME' not found in the secret."
    exit 1
  fi

  # Output the variable value
  echo "The value of $VARIABLE_NAME is: $VARIABLE_VALUE"
}

# Call the function with the secret name and variable name
get_secret_variable "fakecustomer" "frontEndUrl"
