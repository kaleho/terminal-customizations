#!/bin/bash

# Function to perform git operations
git_auto_commit_push() {
    # Check if we're in a git repository
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Error: This is not a git repository"
        return 1
    fi
    
    # Add all changes
    git add .
    
    # Check if there are changes to commit
    if [ -z "$(git status -s)" ]; then
        echo "Working tree is clean. No changes to commit."
    else
        # Commit changes with a timestamp
        commit_message="Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
        git commit -m "$commit_message"
        # Push to origin
        git push origin HEAD
        echo "Changes have been committed and pushed to origin."
    fi
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
    local iterations=$1
    local count=1

    echo "Starting Git Auto Commit Loop. Press Ctrl+C to stop."
    
    # If iterations is empty or 0, run indefinitely
    if [ -z "$iterations" ] || [ "$iterations" -eq 0 ]; then
        while true; do
            echo "Iteration $count (Running indefinitely)"
            git_auto_commit_push
            display_countdown 300
            ((count++))
        done
    else
        while [ $count -le "$iterations" ]; do
            echo "Iteration $count of $iterations"
            git_auto_commit_push
            
            # Only display countdown if not the last iteration
            if [ $count -lt "$iterations" ]; then
                display_countdown 300
            fi
            ((count++))
        done
        echo "Completed $iterations iterations. Exiting."
    fi
}
