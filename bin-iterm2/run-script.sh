#!/bin/bash
echo "DIR_CONF: $DIR_CONF"  $DIR_CONF
# Set the PATH_TO_VENV variable if not already set
: ${PATH_TO_VENV:=/Users/apollotang/_x_conf/custom-scripts/bin-iterm2}

# Execute your original script with the correct Python interpreter
exec "$PATH_TO_VENV/.venv/bin/python3.13" "$PATH_TO_VENV/iterm-vim.py" "$@"
