#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Set BASE_DIR and REPO_LIST relative to the script's location
BASE_DIR="c:\users\garyinnerarity\documents\ncam\repos"
REPO_LIST="$SCRIPT_DIR/repos.txt"

# Ensure the base directory exists
mkdir -p "$BASE_DIR"
cd "$BASE_DIR" || exit

# Read the file line by line
while IFS= read -r REPO_URL || [ -n "$REPO_URL" ]; do
    # Extract repository name from URL
    REPO_NAME=$(basename "$REPO_URL" .git)

    if [ -d "$REPO_NAME" ]; then
        # If repository exists, pull the latest changes
        echo "Updating $REPO_NAME..."
        cd "$REPO_NAME" || exit
        git pull origin main || git pull origin master
        cd ..
    else
        # If repository doesn't exist, clone it
        echo "Cloning $REPO_NAME..."
        git clone "$REPO_URL"
    fi
done < "$REPO_LIST"

echo "All repositories are up to date."
