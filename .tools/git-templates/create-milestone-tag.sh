#!/bin/bash

# Script to create a milestone tag with proper documentation
# This helps track completion of major phases in prompt-based development

# Check for required arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <tag-name> <phase-name> [description]"
    echo "Example: $0 v0.1-phase1 \"Foundation Setup\" \"Completed Firebase setup and basic React components\""
    exit 1
fi

TAG_NAME=$1
PHASE_NAME=$2
DESCRIPTION=${3:-"Completed $PHASE_NAME phase"}

# Function to check if tag exists
tag_exists() {
    git tag | grep -q "^$1\$"
    return $?
}

# Check if the tag already exists
if tag_exists "$TAG_NAME"; then
    echo "❌ Error: Tag '$TAG_NAME' already exists"
    exit 1
fi

# Get the completed tasks for this phase
echo "🔍 Looking for completed tasks in phase: $PHASE_NAME"
COMPLETED_TASKS=""
if [ -f "todo.md" ]; then
    # Extract the phase section and find completed tasks with their IDs
    PHASE_TEXT=$(sed -n "/## .*$PHASE_NAME/,/## /p" todo.md)
    if [ ! -z "$PHASE_TEXT" ]; then
        # Find lines with checkboxes that are checked [x] and include a task ID
        COMPLETED_TASKS=$(echo "$PHASE_TEXT" | grep -E '\[x\].*\*\*\[PROJECT\]-[0-9]+\.[0-9]+\.[0-9]+\*\*' || echo "")
    fi
fi

# Create tag message
TAG_MESSAGE="Milestone: $PHASE_NAME\n\n$DESCRIPTION\n"

# Add completed tasks to message if found
if [ ! -z "$COMPLETED_TASKS" ]; then
    TAG_MESSAGE="$TAG_MESSAGE\n## Completed Tasks:\n$COMPLETED_TASKS\n"
fi

# Get the commits since the last tag
LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")
if [ ! -z "$LAST_TAG" ]; then
    COMMIT_LOG=$(git log --pretty=format:"- %h %s" $LAST_TAG..HEAD)
    if [ ! -z "$COMMIT_LOG" ]; then
        TAG_MESSAGE="$TAG_MESSAGE\n## Commits:\n$COMMIT_LOG\n"
    fi
fi

# Create the tag
echo -e "$TAG_MESSAGE" | git tag -a "$TAG_NAME" -m "$(cat -)"

# Verify tag was created
if tag_exists "$TAG_NAME"; then
    echo "✅ Successfully created milestone tag: $TAG_NAME"
    echo "To push this tag to the remote repository:"
    echo "  git push origin $TAG_NAME"
else
    echo "❌ Failed to create tag"
    exit 1
fi

exit 0