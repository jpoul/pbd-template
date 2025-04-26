#!/bin/bash

# Setup script for Prompt-Based Development template
echo "🚀 Setting up your Prompt-Based Development project..."

# Parse command line arguments
PROJECT_ID=""
SKIP_GH_CLI=false

# Process arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --skip-gh-cli) SKIP_GH_CLI=true ;;
    --project-id) PROJECT_ID="$2"; shift ;;
    *) 
      if [ -z "$PROJECT_ID" ]; then
        PROJECT_ID="$1"
      else
        echo "Unknown parameter: $1"
        echo "Usage: ./setup.sh [project-id] [--skip-gh-cli] [--project-id PROJECT_ID]"
        exit 1
      fi
      ;;
  esac
  shift
done

# Get project identifier if not provided via command line
if [ -z "$PROJECT_ID" ]; then
  echo "Enter your project identifier (e.g., my-project):"
  read PROJECT_ID
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

# GitHub CLI installation section
if [ "$SKIP_GH_CLI" = false ]; then
  if [ -t 0 ]; then # Check if running in interactive terminal
    echo ""
    echo "📦 Would you like to install GitHub CLI for easier issue and PR management? (y/n)"
    read -r install_gh
  else
    # Default to no in non-interactive mode
    install_gh="n"
  fi

  if [[ $install_gh =~ ^[Yy]$ ]]; then
    echo "🔍 Detecting operating system..."
    OS="$(uname -s)"
    
    case "${OS}" in
      Linux*)
        echo "🐧 Linux detected"
        if command -v apt-get &> /dev/null; then
          echo "📥 Installing GitHub CLI using apt..."
          sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
          sudo apt-add-repository https://cli.github.com/packages
          sudo apt update
          sudo apt install gh
        elif command -v dnf &> /dev/null; then
          echo "📥 Installing GitHub CLI using dnf..."
          sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
          sudo dnf install gh
        elif command -v yum &> /dev/null; then
          echo "📥 Installing GitHub CLI using yum..."
          sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
          sudo yum install gh
        else
          echo "❌ Could not detect package manager. Please install GitHub CLI manually:"
          echo "https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
        fi
        ;;
      Darwin*)
        echo "🍎 MacOS detected"
        if command -v brew &> /dev/null; then
          echo "📥 Installing GitHub CLI using Homebrew..."
          brew install gh
        else
          echo "📥 Installing Homebrew and GitHub CLI..."
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
          brew install gh
        fi
        ;;
      MINGW*|MSYS*|CYGWIN*)
        echo "🪟 Windows detected"
        echo "Choose installation method:"
        echo "1. Using winget (Windows Package Manager)"
        echo "2. Using Chocolatey"
        echo "3. Using Scoop"
        echo "4. Skip (install manually)"
        read -r win_choice
        
        case $win_choice in
          1)
            echo "📥 Installing GitHub CLI using winget..."
            winget install --id GitHub.cli
            ;;
          2)
            echo "📥 Installing GitHub CLI using Chocolatey..."
            choco install gh
            ;;
          3)
            echo "📥 Installing GitHub CLI using Scoop..."
            scoop install gh
            ;;
          *)
            echo "⏭️ Skipping GitHub CLI installation"
            echo "📝 You can install it later from: https://github.com/cli/cli#installation"
            ;;
        esac
        ;;
      *)
        echo "❓ Unknown operating system"
        echo "📝 Please install GitHub CLI manually: https://github.com/cli/cli#installation"
        ;;
    esac
    
    # Set up GitHub CLI authentication if installation was successful
    if command -v gh &> /dev/null; then
      if [ -t 0 ]; then # Check if running in interactive terminal
        echo "🔐 Would you like to authenticate with GitHub now? (y/n)"
        read -r setup_auth
        if [[ $setup_auth =~ ^[Yy]$ ]]; then
          gh auth login
        else
          echo "⏭️ Skipping GitHub authentication"
          echo "📝 You can run 'gh auth login' later to authenticate"
        fi
      else
        echo "⏭️ Skipping GitHub authentication (non-interactive mode)"
      fi
    fi
  else
    echo "⏭️ Skipping GitHub CLI installation"
  fi
else
  echo "⏭️ Skipping GitHub CLI installation (--skip-gh-cli flag detected)"
fi

# Initial commit if it's a new repository and no commits exist yet
if [ -d .git ] && [ -z "$(git log -1 2>/dev/null)" ]; then
  echo "📦 Creating initial commit..."
  git add .
  git commit -m "Initial commit from Prompt-Based Development template"
fi

echo "✅ Setup complete! Your project is ready to use."
echo "📚 Check the README.md for next steps and workflow information."