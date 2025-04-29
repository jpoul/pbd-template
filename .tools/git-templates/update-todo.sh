#!/bin/bash

# Automated Todo Update Script
# This script updates todo.md by marking tasks as complete based on the current commit message
# It also marks all related subtasks as complete
# It stages the updated todo.md file so it is included in the commit

# Path to the todo file
TODO_FILE="docs/specification/todo.md"

# Check if todo file exists
if [ ! -f "$TODO_FILE" ]; then
  echo "❌ Error: Todo file not found at $TODO_FILE"
  exit 1
fi

# Get the commit message from the argument
if [ -z "$1" ]; then
  echo "❌ Error: Commit message not provided"
  echo "Usage: $0 \"<commit message>\""
  exit 1
fi

COMMIT_MSG="$1"
echo "🔍 Processing commit message: $COMMIT_MSG"

# Extract task ID from commit message (format: [ANY-X.Y.Z])
if [[ $COMMIT_MSG =~ \[([A-Za-z]+-[0-9]+\.[0-9]+\.[0-9]+)\] ]]; then
  TASK_ID="${BASH_REMATCH[1]}"
  TASK_ID_UPPER=$(echo "$TASK_ID" | tr '[:lower:]' '[:upper:]')
  echo "📝 Found task reference: $TASK_ID_UPPER"

  # Create temporary file
  TEMP_FILE="${TODO_FILE}.tmp"
  > "$TEMP_FILE" # Ensure temp file is empty
  
  # Flag to track if we found the task and if we're in its subtasks
  FOUND_TASK=0
  IN_SUBTASKS=0
  
  # Counter for tasks updated
  TASKS_UPDATED=0
  
  # Read the todo file line by line
  while IFS= read -r line || [ -n "$line" ]; do
    # Check if this is the main task line
    if [[ "$line" == *"**${TASK_ID_UPPER}**"* ]]; then
      FOUND_TASK=1
      IN_SUBTASKS=1
      
      # If the main task is not complete, mark it complete
      if [[ "$line" == *"- [ ]"* ]]; then
        line=$(echo "$line" | sed 's/- \[ \]/- [x]/')
        TASKS_UPDATED=$((TASKS_UPDATED+1))
        echo "✅ Marked main task $TASK_ID_UPPER as complete"
      else
        echo "ℹ️ Main task $TASK_ID_UPPER already complete, checking subtasks..."
      fi
      
      # Write the processed line to the temp file
      echo "$line" >> "$TEMP_FILE"
    
    # Check if we're processing subtasks of the found task
    elif [[ $IN_SUBTASKS -eq 1 ]]; then
      # Check if this line is a subtask (indented and has a checkbox)
      if [[ "$line" == *"  - [ ]"* ]]; then
        # This is an unchecked subtask, mark it complete
        line=$(echo "$line" | sed 's/- \[ \]/- [x]/')
        TASKS_UPDATED=$((TASKS_UPDATED+1))
        echo "✅ Marked subtask as complete"
      
      # Check if we've reached the next main task (non-indented and starts with dash)
      elif [[ "$line" =~ ^"- " ]]; then
        # End of subtask section
        IN_SUBTASKS=0
      fi
      
      # Write the processed line to the temp file
      echo "$line" >> "$TEMP_FILE"
    
    # All other lines are unchanged
    else
      echo "$line" >> "$TEMP_FILE"
    fi
  done < "$TODO_FILE"
  
  # Replace original file if any tasks were updated
  if [[ $TASKS_UPDATED -gt 0 ]]; then
    cp "$TEMP_FILE" "$TODO_FILE"
    echo "🎉 Successfully updated $TASKS_UPDATED tasks in $TODO_FILE"
    
    # Stage the updated todo file
    git add "$TODO_FILE"
    echo "✅ Staged updated $TODO_FILE"
  else
    if [[ $FOUND_TASK -eq 1 ]]; then
      echo "ℹ️ Task $TASK_ID_UPPER and all its subtasks are already complete"
    else
      echo "⚠️ Task $TASK_ID_UPPER not found in $TODO_FILE"
    fi
  fi
  
  # Clean up temp file
  rm -f "$TEMP_FILE"

else
  echo "❌ No task ID found in commit message: $COMMIT_MSG"
  exit 1
fi

exit 0