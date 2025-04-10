#!/bin/bash

################################################################################
# Script Name: edit-in-cot.sh
# Description: This script lists all the available functions defined in the script 
#              with an alphabet as a key label. It then prompts the user to enter
#              the alphabet corresponding to the function they want to execute.
# Author: Qwen (Created by Alibaba Cloud)
################################################################################

################################################################################
# Usage:
# 1. Save this script to a file, for example, `function_selector.sh`.
# 2. Make the script executable: `chmod +x function_selector.sh`.
# 3. Run the script: `./function_selector.sh`.
#
# Example:
# ./edit-in-cot.sh
#
# This will display a list of functions with alphabet labels like:
# [a] example_function1
# [b] example_function2
# [c] another_example
#
# Enter the corresponding letter to execute the desired function.
################################################################################

################################################################################
# Function Definitions:
# Define your functions here. For example:
edit-common-alias() {
    echo "open common-alias in editor"
    cot  ~/_x_conf/settings/tools/bash/bash-common/common-aliases.sh
}

edit-bashrc() {
    echo "open bashrc in editor"
    cot  ~/_x_conf/settings/tools/bash/bashrc.sh
}

################################################################################

# Function to list all functions and prompt for selection
function select_function {
    # Get all function names defined in the script
    local functions=($(declare -F | awk '{print $3}'))
    
    # Check if there are any functions
    if [ ${#functions[@]} -eq 0 ]; then
        echo "No functions found in the script."
        return
    fi

    # Create an array to hold function labels
    local labels=()
    
    echo "Available functions:"
    for ((i=0; i<${#functions[@]}; i++)); do
        # Get the corresponding alphabet label
        local label=$(echo $((i+97)) | tr '0-9' 'a-z')
        echo "[$label] ${functions[i]}"
        labels+=($label)
    done

    # Prompt the user to enter a function label
    read -p "Enter the letter of the function you want to execute: " choice

    # Check if the entered choice is valid
    if [[ ! " ${labels[@]} " =~ " $choice " ]]; then
        echo "Invalid choice. Please try again."
        return
    fi

    # Get the index of the chosen label
    local index=$(printf "%s\n" "${labels[@]}" | grep -n "^$choice$" | cut -d: -f1)
    index=$((index-1))

    # Execute the selected function
    ${functions[$index]}
}

# Call the select_function to display menu and execute chosen function
select_function
