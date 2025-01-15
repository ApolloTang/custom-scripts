#!/bin/bash

# Check if a filename is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <filename.enc>"
  exit 1
fi

# Assign the input argument to a variable
encrypted_file="$1"

# Check if the file exists and has the .enc extension
if [ ! -f "$encrypted_file" ]; then
  echo "Error: File '$encrypted_file' not found."
  exit 1
fi

if [[ "$encrypted_file" != *.enc ]]; then
  echo "Error: File must have a .enc extension."
  exit 1
fi

# Ask for the password
read -sp "Enter password: " password
echo

# Decrypt the file and capture both stdout and stderr
decrypted_output=$(openssl enc -aes-256-cbc -d -pbkdf2 -iter 100000 -in "$encrypted_file" -k "$password" 2>&1)

# Check if decryption was successful
if [ $? -eq 0 ]; then
  echo "Decrypted content:"
  echo "$decrypted_output"
else
  echo "Error: Decryption failed."
  echo "Details: $decrypted_output"
  exit 1
fi

