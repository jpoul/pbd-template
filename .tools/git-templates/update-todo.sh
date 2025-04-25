#!/bin/bash

# Automated Todo Update Script
# This script updates todo.md by marking tasks as complete based on commit messages
# It can be run manually or integrated with git hooks

echo "🔍 Checking for tasks to mark as complete..."

# Path to the todo file - can be changed if needed
TODO_FILE="todo.md"

# Check if todo file exists
if [ ! -f "$TODO_FILE" ]; then
  echo "❌ Error: Todo file not found at $TODO_FILE"
  exit 1
fi

# Get recent commits that haven't been processed yet
# We use a marker file to track the last processed commit
MARKER_FILE=".todo-marker"
LAST_PROCESSED_COMMIT=""

if [ -f "$MARKER_FILE" ]; then
  LAST_PROCESSED_COMMIT=$(cat "$MARKER_FILE")
fi

# If we have a marker, get commits since then, otherwise limit to last 10
if [ -n "$LAST_PROCESSED_COMMIT" ]; then
  COMMITS=$(git log --pretty=format:"%H %s" $LAST_PROCESSED_COMMIT..HEAD)
else
  COMMITS=$(git log --pretty=format:"%H %s" -10)
fi

# If no new commits, exit
if [ -z "$COMMITS" ]; then
  echo "✅ No new commits to process"
  exit 0
fi

# Keep track of the most recent commit
MOST_RECENT_COMMIT=$(echo "$COMMITS" | head -n 1 | cut -d' ' -f1)

# Counter for tasks marked as complete
TASKS_UPDATED=0

# Process each commit
echo "$COMMITS" | while read -r COMMIT_HASH COMMIT_MSG; do
  # Extract task ID from commit message (format: [PROJECT-X.Y.Z])
  if [[ $COMMIT_MSG =~ \[(.*?-[0-9]+\.[0-9]+\.[0-9]+)\] ]]; then
    TASK_ID="${BASH_REMATCH[1]}"
    echo "📝 Found task reference: $TASK_ID"
    
    # Escape special characters for sed
    ESCAPED_TASK_ID=$(echo "$TASK_ID" | sed 's/[\/&]/\\&/g')
    
    # Look for the task in todo.md and mark it as complete if it's not already
    # We're looking for lines like: - [ ] **TASK-1.2.3** Task description
    if grep -q "\- \[ \] \*\*$TASK_ID\*\*" "$TODO_FILE"; then
      sed -i "s/- \[ \] \*\*$ESCAPED_TASK_ID\*\*/- \[x\] \*\*$ESCAPED_TASK_ID\*\*/g" "$TODO_FILE"
      echo "✅ Marked task $TASK_ID as complete"
      ((TASKS_UPDATED++))
    else
      # If we didn't find an exact match, it might be either already complete or have
      # a different format, so let's just inform the user
      if grep -q "\*\*$TASK_ID\*\*" "$TODO_FILE"; then
        echo "ℹ️ Task $TASK_ID already found in todo.md (might already be complete)"
      else
        echo "⚠️ Task $TASK_ID not found in todo.md"
      fi
    fi
  fi
done

# Update the marker to the most recent commit
echo "$MOST_RECENT_COMMIT" > "$MARKER_FILE"

# Summary
if [ $TASKS_UPDATED -gt 0 ]; then
  echo "🎉 Successfully updated $TASKS_UPDATED tasks in $TODO_FILE"
else
  echo "ℹ️ No tasks were updated in $TODO_FILE"
fi

exit 0