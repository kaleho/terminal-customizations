#!/bin/bash

# Function to perform git operations
git_auto_commit_push() {
    # Check if we're in a git repository
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "Error: This is not a git repository"
        return 1
    fi

    # Check if the working tree is clean
    if [[ -z $(git status -s) ]]; then
        echo "Working tree is clean. Nothing to do."
        return 0
    fi

    # Add all changes
    git add .

    # Commit changes with a timestamp
    commit_message="Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
    git commit -m "$commit_message"

    # Push to origin
    git push origin HEAD

    echo "Changes have been committed and pushed to origin."
}

# Function to display countdown
display_countdown() {
    local seconds=$1
    local start=$SECONDS
    while [ $((SECONDS - start)) -lt $seconds ]; do
        local elapsed=$((SECONDS - start))
        local remaining=$((seconds - elapsed))
        printf "\rNext autosave in %02d:%02d" $((remaining / 60)) $((remaining % 60))
        sleep 10
    done
    echo ""  # Move to a new line after countdown
}

autosave() {
    # Main loop
    echo "Starting Git Auto Commit Loop. Press Ctrl+C to stop."

    while true; do
        # Run the git auto-commit-push function
        git_auto_commit_push

        # Display countdown for 5 minutes (300 seconds)
        display_countdown 300
    done
}
