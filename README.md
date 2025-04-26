# Prompt-Based Development Template

This template provides a foundation for projects that use AI prompts and Test-Driven Development (TDD) to build software systematically. It integrates Git workflows, testing frameworks, and documentation templates designed to optimize development when working with language models.

Inspired by [Harper Reed's LLM codegen workflow](https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm)

## Quick Start

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
- Create an initial commit

## Workflow Overview

This template implements a prompt-based development workflow that:

1. Breaks down projects into clear, testable tasks with unique IDs
2. Uses a TDD approach (write tests first, then implementation)
3. Leverages AI prompts for consistent, step-by-step development
4. Maintains traceability between code changes and task IDs

## Directory Structure

- `.github/` - GitHub Actions workflows and PR templates
- `.tools/` - Development tools, setup scripts, and Git hooks
- `docs/` - Project documentation and AI prompts
  - `prompts/` - AI prompts used to guide development
  - `sample/` - Example artifacts and templates

## Git Hooks

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

## Documentation

- [Git workflow strategy](.tools/git-templates/git_workflow.md) - Details on the Git workflow strategy
- [Guide to creating prompts](docs/prompts/README.md) - Guide to creating effective prompts for development
- [Process Guide](docs/process-guide.md) - Complete process for prompt-based development from idea to implementation
- [Todo Template](docs/todo-template.md) - Template for structuring development tasks

## Customizing for Your Project

1. Define your task structure in a `todo.md` file using the [Todo Template](docs/todo-template.md)
2. Create project-specific prompts in `docs/prompts/` following the [prompts guide](docs/prompts/README.md)
3. Configure your test framework (the template works with Jest)
4. Adjust GitHub Actions workflows as needed

## License

[MIT License](LICENSE)