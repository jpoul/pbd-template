# Prompt-Based Development Template

Inspired by [Harper Reed's LLM codegen workflow](https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm)

This template provides a foundation for projects that use AI prompts and Test-Driven Development (TDD) to build software systematically. It integrates Git workflows, testing frameworks, and documentation templates designed to optimize development when working with language models.

The Prompt-Based Development workflow:

1. Breaks down projects into clear, testable tasks with unique IDs
2. Uses a TDD approach (write tests first, then implementation)
3. Leverages AI prompts for consistent, step-by-step development
4. Maintains traceability between code changes and task IDs

## Repository Setup

Run the setup script to configure your project:

```bash
# On macOS/Linux or Git Bash on Windows
./.tools/setup.sh your-project-id

# Or with PowerShell on Windows
& 'C:\Program Files\Git\bin\bash.exe' -c './.tools/setup.sh your-project-id'
```

The setup script will:
- Replace placeholder values with your project ID
- Initialize git repository (if needed)
- Install git hooks for TDD workflow
- Optionally install GitHub CLI for easier issue and PR management
- Create an initial commit

### Command-line Options

For automated setups, you can use these command-line options:

```bash
# Skip GitHub CLI installation
./.tools/setup.sh your-project-id --skip-gh-cli

# Specify project ID with a named parameter
./.tools/setup.sh --project-id your-project-id

# Combine options
./.tools/setup.sh --project-id your-project-id --skip-gh-cli
```

### Git Hooks

Our Git hooks enforce TDD principles and consistent commit messages. They will:

- Run tests before allowing commits (when Jest is configured)
- Check test coverage thresholds
- Validate commit message formats
- Ensure test files are updated with implementation changes

If you need to reinstall the hooks manually:

```bash
chmod +x .tools/git-templates/install-hooks.sh
./.tools/git-templates/install-hooks.sh
```

## Directory Structure

- `.github/` - GitHub Actions workflows and PR templates
- `.tools/` - Development tools, setup scripts, and Git hooks
- `docs/` - Project documentation
  - `sample/` - Example artifacts and templates showing the development flow

## Getting Started

To get started with your project, refer to these resources:

### [Process Guide](docs/process-guide.md)
This comprehensive guide explains the entire prompt-based development process from initial idea to implementation, including:
- Specification Creation
- Blueprint Development
- Task Breakdown
- Implementation and TDD practices

### [Git Workflow Strategy](.tools/git-templates/git_workflow.md)
Documentation on the Git workflow strategy that integrates with the prompt-based development process.

## Sample Outcome

The `docs/sample/` directory contains example artifacts from a complete prompt-based development cycle for a Todo Application project. This sample demonstrates how the development process flows from idea to implementation:

- `spec.md` - Initial project specification for the Todo App
- `blueprint.md` - Architectural blueprint breaking down the application components
- `components.mmd` - Component diagram showing the application structure
- `prompt_plan.md` - Sample prompting plan for implementing the Todo App
- `todo.md` - Task breakdown with unique identifiers following TDD principles

## License

[MIT License](LICENSE)