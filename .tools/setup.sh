#!/bin/bash

# Setup script for Prompt-Based Development template
echo "🚀 Setting up your Prompt-Based Development project..."

# Get project identifier
if [ -z "$1" ]; then
  echo "Enter your project identifier (e.g., my-project):"
  read PROJECT_ID
else
  PROJECT_ID=$1
fi

# Replace placeholders in files
echo "📝 Replacing placeholders with '$PROJECT_ID'..."
find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/coverage/*" -exec sed -i "s/\[PROJECT\]/$PROJECT_ID/g" {} \;

# Initialize git (if not already initialized)
if [ ! -d .git ]; then
  echo "🔄 Initializing git repository..."
  git init
else
  echo "ℹ️ Git repository already initialized"
fi

# Install git hooks
echo "🔧 Installing git hooks..."
if [ -f .tools/git-templates/install-hooks.sh ]; then
  chmod +x .tools/git-templates/install-hooks.sh
  ./.tools/git-templates/install-hooks.sh
else
  echo "❌ Could not find install-hooks.sh script"
fi

# Initial commit if it's a new repository and no commits exist yet
if [ -d .git ] && [ -z "$(git log -1 2>/dev/null)" ]; then
  echo "📦 Creating initial commit..."
  git add .
  git commit -m "Initial commit from Prompt-Based Development template"
fi

echo "✅ Setup complete! Your project is ready to use."
echo "📚 Check the README.md for next steps and workflow information."