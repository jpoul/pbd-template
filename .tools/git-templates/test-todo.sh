#!/bin/bash

# Test script for update-todo.sh
# Usage: ./test-todo.sh "[zeno-1.1.2] Test commit message"

if [ -z "$1" ]; then
  echo "❌ Error: Please provide a test commit message"
  echo "Usage: ./test-todo.sh \"[zeno-1.1.2] Test commit message\""
  exit 1
fi

# Simulate commit message
TEST_COMMIT_MSG="$1"
echo "🔍 Testing with commit message: $TEST_COMMIT_MSG"

# Path to todo file
TODO_FILE="docs/specification/todo.md"

# Check if todo file exists
if [ ! -f "$TODO_FILE" ]; then
  echo "❌ Error: Todo file not found at $TODO_FILE"
  exit 1
fi

echo "📄 Todo file found: $TODO_FILE"

# Debug - print a few lines from todo to verify content
echo "📋 First few unchecked tasks in todo file:"
grep -n "\- \[ \]" "$TODO_FILE" | head -3

# Extract task ID from commit message (format: [PROJECT-X.Y.Z])
if [[ $TEST_COMMIT_MSG =~ \[(zeno-[0-9]+\.[0-9]+\.[0-9]+)\] ]]; then
  TASK_ID="${BASH_REMATCH[1]}"
  TASK_ID_UPPER=$(echo "$TASK_ID" | tr '[:lower:]' '[:upper:]')
  echo "📝 Found task reference: $TASK_ID_UPPER"
  
  # Escape special characters for sed
  ESCAPED_TASK_ID=$(echo "$TASK_ID_UPPER" | sed 's/[\/&]/\\&/g')
  
  # Debug - show exactly what pattern we're searching for
  echo "🔍 Searching for pattern: \"- \[ \] \*\*${ESCAPED_TASK_ID}\*\*\""
  
  # Debug - run grep with the pattern and show result
  echo "🔍 Grep result:"
  grep "- \[ \] \*\*${ESCAPED_TASK_ID}\*\*" "$TODO_FILE" || echo "No match found"
  
  # Look for the task in todo.md and mark it as complete if it's not already
  # Match any line containing: - [ ] **TASKID** (regardless of what follows)
  if grep -q "- \[ \] \*\*${ESCAPED_TASK_ID}\*\*" "$TODO_FILE"; then
    echo "✅ Match found! Updating task $TASK_ID_UPPER to complete..."
    
    # Create a backup before making changes
    cp "$TODO_FILE" "${TODO_FILE}.bak"
    
    # Debug - show what the sed command will do
    echo "🔧 Sed command: s/- \\[ \\] \\*\\*${ESCAPED_TASK_ID}\\*\\*/- [x] **${ESCAPED_TASK_ID}**/g"
    
    # Apply the change
    sed -i "s/- \[ \] \*\*${ESCAPED_TASK_ID}\*\*/- [x] **${ESCAPED_TASK_ID}**/g" "$TODO_FILE"
    
    # Debug - show the difference
    echo "📊 Changes made:"
    diff "${TODO_FILE}.bak" "$TODO_FILE" || echo "No changes detected (diff returned non-zero)"
    
    echo "✅ Marked task $TASK_ID_UPPER as complete"
  else
    # If we didn't find an exact match, it might be either already complete or have
    # a different format, so let's just inform the user
    if grep -q "\*\*${ESCAPED_TASK_ID}\*\*" "$TODO_FILE"; then
      echo "ℹ️ Task $TASK_ID_UPPER already found in todo.md (might already be complete)"
      
      # Debug - show the line where the task ID was found
      echo "📄 Existing task line:"
      grep -n "\*\*${ESCAPED_TASK_ID}\*\*" "$TODO_FILE"
    else
      echo "⚠️ Task $TASK_ID_UPPER not found in todo.md"
    fi
  fi
else
  echo "❌ No task ID found in commit message: $TEST_COMMIT_MSG (regex failed)"
  echo "Commit message should include task ID in format [zeno-X.Y.Z]"
  # Debug output for regex debugging
  echo "DEBUG: Testing regex with explicit pattern match:"
  if [[ $TEST_COMMIT_MSG =~ \[zeno-[0-9]+\.[0-9]+\.[0-9]+\] ]]; then
    echo "✅ Basic pattern match succeeded"
    echo "Found: ${BASH_REMATCH[0]}"
  else
    echo "❌ Basic pattern match failed"
  fi
fi

echo "✅ Test complete"
exit 0