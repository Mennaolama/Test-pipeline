#!/bin/bash

# Function to retrieve a specific variable from a given parameter path
get_ssm_parameter() {
  local PARAMETER_PREFIX=$1
  local VARIABLE_NAME=$2

  # Construct the full parameter name
  local PARAMETER_NAME="${PARAMETER_PREFIX}${VARIABLE_NAME}"

  # Retrieve the parameter value from AWS Systems Manager Parameter Store
  PARAMETER_VALUE=$(aws ssm get-parameter --name "$PARAMETER_NAME" --with-decryption --query "Parameter.Value" --output text 2>/dev/null)
  
  if [ $? -ne 0 ]; then
    echo "Error: Unable to retrieve parameter. Make sure the parameter name '$PARAMETER_NAME' is correct and you have the necessary permissions."
    exit 1
  fi

  # Check if the parameter value is null
  if [ -z "$PARAMETER_VALUE" ]; then
    echo "Error: Parameter '$VARIABLE_NAME' not found in the Parameter Store."
    exit 1
  fi

  # Output the parameter value
  echo "The value of $VARIABLE_NAME is: $PARAMETER_VALUE"
}

# Call the function with the parameter prefix and variable name
#get_ssm_parameter "/fakecustomer/" "logStreamName"
