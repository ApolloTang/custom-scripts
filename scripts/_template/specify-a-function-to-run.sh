#!/bin/bash

# This script allows you to specify a function to run from the command line.
# Usage: ./specify-a-function-to-run.sh <function_name> [arguments...]
# Example: ./specify-a-function-to-run.sh foo arg1 arg2
#
# Available functions:
# - foo: Executes the foo function with the provided arguments.
# - help: Lists all available functions.
#
# If the specified function is not present in the script, it will display an error message
# and list all available functions.


# Define your functions here
foo() {
    echo "executing: foo $@"
}

help() {
    echo "Available functions are:"
    declare -F | awk '{print $3}'
}

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <function_name> [arguments...]"
    exit 1
fi

# Extract the function name from the first argument
func_name=$1
shift

# Check if the function exists and call it with the remaining arguments
if declare -f "$func_name" > /dev/null; then
    "$func_name" "$@"
else
    echo "No such function called $func_name"
    echo "Available functions are:"
    declare -F | awk '{print $3}'
    exit 1
fi