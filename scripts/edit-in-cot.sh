#!/bin/bash

# Define your functions here
common-alias() {
    echo "open common-alias in editor"
    cot  ~/_x_conf/settings/tools/bash/bash-common/common-aliases.sh
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