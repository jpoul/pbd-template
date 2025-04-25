# Prompt-Based Development Template

Inspired by [Harper Reed's LLM codegen workflow atm](https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm)

This template provides a foundation for projects that use AI prompts and Test-Driven Development (TDD) to build software systematically. It includes directory structures, Git workflows, and documentation templates designed to optimize the development process when working with language models.

## Getting Started

1. Create a new repository from this template
2. Replace `[PROJECT]` with your project identifier throughout the files
3. Set up the Git workflow by following the instructions in `.tools/git-templates/git_workflow.md`
4. Customize the directory structure as needed for your specific project

## Directory Structure

- `.github/` - GitHub-specific files
  - `workflows/` - GitHub Actions workflow configurations
  - `PULL_REQUEST_TEMPLATE/` - PR templates for GitHub
- `.tools/` - Development tools and utilities
  - `git-templates/` - Git workflow templates and hooks
- `docs/` - Project documentation
  - `prompts/` - AI prompts used to guide development

## Workflow Overview

This template implements a prompt-based development workflow that:

1. Breaks down projects into clear, testable tasks with unique IDs
2. Uses a TDD approach (write tests first, then implementation)
3. Leverages AI prompts for consistent, step-by-step development
4. Maintains traceability between code changes and task IDs
5. Integrates with GitHub for project management

## Setting Up Git Hooks

### On Windows:

Our Git hooks and scripts are written in Bash. To use them on Windows:

1. **Use Git Bash** (Recommended):
   ```bash
   # Open Git Bash in your project directory
   cd your-project
   # Make the script executable
   chmod +x .tools/git-templates/install-hooks.sh
   # Run the installation script
   ./.tools/git-templates/install-hooks.sh
   ```

2. **Alternative: Windows Subsystem for Linux (WSL)**:
   ```bash
   wsl
   cd /mnt/c/path/to/your/project
   chmod +x .tools/git-templates/install-hooks.sh
   ./.tools/git-templates/install-hooks.sh
   ```

3. **Alternative: PowerShell with Git for Windows**:
   ```powershell
   # Run this in PowerShell
   & 'C:\Program Files\Git\bin\bash.exe' -c './.tools/git-templates/install-hooks.sh'
   ```

### On macOS/Linux:

```bash
# Make the script executable
chmod +x .tools/git-templates/install-hooks.sh
# Run the installation script
./.tools/git-templates/install-hooks.sh
```

## Documentation

- `.tools/git-templates/git_workflow.md` - Details on the Git workflow strategy
- `docs/prompts/README.md` - Guide to creating effective prompts for development

## How to Customize

To adapt this template for your project:

1. Define your task structure in a `todo.md` file
2. Create project-specific prompts in `docs/prompts/`
3. Set up your test framework following the TDD principles
4. Configure GitHub Actions for your CI/CD needs

## License

[MIT License](LICENSE)