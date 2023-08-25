#!/bin/bash

# Your GitHub username
USERNAME="HugoSilva92"

# Get a list of your repositories using the GitHub API
REPOS_JSON=$(curl -s "https://api.github.com/users/$USERNAME/repos")

# Loop through the repositories and clone or pull
for repo in $(echo "$REPOS_JSON" | jq -r '.[].ssh_url'); do
    repo_name=$(basename $repo .git)
    
    if [ -d "$repo_name" ]; then
        # If the repository exists locally, pull the latest changes
        echo "Pulling $repo_name..."
        cd "$repo_name"
        git pull
        cd -
    else
        # If the repository doesn't exist locally, clone it
        echo "Cloning $repo_name..."
        git clone $repo
    fi
done

