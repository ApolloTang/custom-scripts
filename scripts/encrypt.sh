#!/bin/bash

# Check if a filename is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Assign the input argument to a variable
filename="$1"

# Check if the file exists
if [ ! -f "$filename" ]; then
  echo "Error: File '$filename' not found."
  exit 1
fi

# Check if the output file already exists
if [ -f "${filename}.enc" ]; then
  echo "Error: Output file '${filename}.enc' already exists. Aborting to prevent overwriting."
  exit 1
fi

# Ask for a password and confirm it
while true; do
  read -sp "Enter password: " password
  echo
  read -sp "Confirm password: " password_confirm
  echo

  if [ "$password" == "$password_confirm" ]; then
    break
  else
    echo "Passwords do not match. Please try again."
  fi
done

# Encrypt the file using OpenSSL with PBKDF2 and capture stderr
encrypt_output=$(openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 -in "$filename" -out "${filename}.enc" -k "$password" 2>&1)

# Check if encryption was successful
if [ $? -eq 0 ]; then
  echo "File encrypted successfully: ${filename}.enc"
else
  echo "Error: Encryption failed."
  echo "Details: $encrypt_output"
  # Clean up the output file if encryption fails
  rm -f "${filename}.enc"
  exit 1
fi

