#!/bin/bash

# Description: This script renames files within a specified directory to kebab-case.
#              It converts spaces, underscores, and dots in filenames to hyphens,
#              lowercases all characters, and removes multiple consecutive hyphens 
#              or leading/trailing hyphens. The script only operates on files in 
#              the given directory and does not recurse into subdirectories.
#
# Usage: ./script_name.sh <directory_path>
#   - <directory_path>: The path to the directory containing the files to rename.
#
# Example:
#   ./script_name.sh /path/to/my/files
#

# Function to convert a string to kebab-case
to_kebab_case() {
  local input="$1"
  local output

  # Replace spaces, underscores, and dots with hyphens
  output=$(echo "$input" | tr ' _.' '-')

  # Convert to lowercase
  output=$(echo "$output" | tr '[:upper:]' '[:lower:]')

  # Remove multiple hyphens
  output=$(echo "$output" | sed 's/--\+/-/g')

  # Remove leading and trailing hyphens
  output=$(echo "$output" | sed 's/^-//;s/-$//')

  echo "$output"
}

# Check if a directory path is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <directory_path>"
  exit 1
fi

directory_path="$1"

# Check if the specified path is a directory
if [ ! -d "$directory_path" ]; then
  echo "Error: '$directory_path' is not a directory."
  exit 1
fi

# Iterate through files in the specified directory
# Only search in the current directory, not subdirectories.
find "$directory_path" -maxdepth 1 -type f -print0 | while IFS= read -r -d $'\0' file; do
    # Extract the filename and extension
    filename=$(basename "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"

    # Convert the filename to kebab-case
    new_filename=$(to_kebab_case "$filename")

    # Construct the new filename with the extension
    new_file="$directory_path/$new_filename.$extension"

    # Rename the file
    if [[ "$file" != "$new_file" ]]; then
      echo "Renaming '$file' to '$new_file'"
      mv "$file" "$new_file"
    fi
done
