#!/bin/bash

# Your GitHub username
USERNAME="HugoSilva92"

# Directory where you want to store the repositories

# Create the directory if it doesn't exist

# Get a list of your repositories using the GitHub API
REPOS_JSON=$(curl -s "https://api.github.com/users/$USERNAME/repos")

# Loop through the repositories and clone or pull
for repo in $(echo "$REPOS_JSON" | jq -r '.[].ssh_url'); do
    repo_name=$(basename $repo .git)
    repo_path="/$repo_name"
    
    if [ -d "$repo_path" ]; then
        # If the repository exists locally, pull the latest changes
        echo "Pulling $repo_name..."
        cd "$repo_path"
        git pull
        cd -
    else
        # If the repository doesn't exist locally, clone it
        echo "Cloning $repo..."
        git clone $repo
    fi
done

