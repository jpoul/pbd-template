#!/bin/bash

echo "🔧 Installing Git hooks for prompt-based TDD workflow..."

# Detect operating system
OS="$(uname -s)"
IS_WINDOWS=false
if [[ "$OS" == *"MINGW"* ]] || [[ "$OS" == *"MSYS"* ]] || [[ "$OS" == *"CYGWIN"* ]]; then
  IS_WINDOWS=true
  echo "🖥️ Windows detected. Using Git Bash paths..."
fi

# Define hooks directory path
HOOKS_SOURCE_DIR=".tools/git-templates/hooks"

# Check if we're in the right directory
if [ ! -d "$HOOKS_SOURCE_DIR" ]; then
  echo "❌ Error: Hooks source directory not found: $HOOKS_SOURCE_DIR"
  echo "Please run this script from the project root directory."
  exit 1
fi

# Make all hooks executable
for HOOK_FILE in "$HOOKS_SOURCE_DIR"/*; do
  if [ -f "$HOOK_FILE" ]; then
    chmod +x "$HOOK_FILE"
    HOOK_NAME=$(basename "$HOOK_FILE")
    echo "✅ Made $HOOK_NAME hook executable"
  fi
done

# Set Git to use our custom hooks directory
ABSOLUTE_HOOKS_PATH="$(pwd)/$HOOKS_SOURCE_DIR"
git config --local core.hooksPath "$HOOKS_SOURCE_DIR"
echo "✅ Configured Git to use hooks from: $HOOKS_SOURCE_DIR"

# Set up commit message template
git config --local commit.template ".tools/git-templates/git-commit-template.txt"
echo "✅ Configured commit message template"

echo ""
echo "🎉 Git hooks successfully installed!"
echo "These hooks will help enforce the prompt-based TDD workflow:"
echo "  - pre-commit: Runs tests and checks coverage before allowing commits"
echo "  - commit-msg: Ensures commit messages follow the task reference format"
echo "  - post-checkout: Provides task context when switching branches"
echo "  - post-commit: Updates todo.md when task-related commits are made"

if [ "$IS_WINDOWS" = true ]; then
  echo ""
  echo "⚠️ Windows-specific notes:"
  echo "  - Make sure to use Git Bash for best compatibility"
  echo "  - If using VSCode's integrated terminal, set it to use Git Bash"
  echo "  - If hooks aren't executing, check file permissions and line endings"
  echo "  - For Windows Powershell, commands need to start with: '& \"C:\\Program Files\\Git\\bin\\bash.exe\" -c \"./.tools/git-templates/script.sh\"'"
fi

echo ""
echo "To bypass hooks temporarily when needed, use the --no-verify flag:"
echo "  git commit --no-verify -m \"[PROJECT-1.2.3] My commit message\""
echo ""