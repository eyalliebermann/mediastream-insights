#!/bin/zsh

# Check if a path parameter is provided, else use the current directory
DIR_TO_SHOW="${1:-.}"

# Run the tree command, excluding certain directories
tree -I 'venv*|__pycache__' "$DIR_TO_SHOW"
