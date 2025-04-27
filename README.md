# Prompt-Based Development Template

Inspired by [Harper Reed's LLM codegen workflow](https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm)

This template provides a foundation for projects that use AI prompts and Test-Driven Development (TDD) to build software systematically. It integrates Git workflows, testing frameworks, and documentation templates designed to optimize development when working with language models.

## Getting Started

The repository includes the following folders:

- `.github/` - GitHub Actions workflows and PR templates
- `.tools/` - Development tools, setup scripts, and Git hooks
- `docs/` - Your project documentation
- `docs/pbd/` - Prompt-Based Development methodology documentation
  - `docs/pbd/README.md` - Comprehensive PBD process guide
  - `docs/pbd/sample/` - Sample artifacts from a Todo App development cycle

### Repository Setup

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

[Read the documentation](.tools/git-templates/git_workflow.md) on the Git workflow strategy that integrates with the prompt-based development process.

#### Command-line Options

For automated setups, you can use these command-line options:

```bash
# Skip GitHub CLI installation
./.tools/setup.sh your-project-id --skip-gh-cli

# Specify project ID with a named parameter
./.tools/setup.sh --project-id your-project-id

# Combine options
./.tools/setup.sh --project-id your-project-id --skip-gh-cli
```

#### Git Hooks

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

### Prompt-Based Development Process

To learn how to use the prompt-based development methodology, review the [PBD Process Guide](/docs/pbd/README.md). This guide explains:

- The complete development workflow from idea to implementation
- How to create specifications, blueprints, and task breakdowns
- Sample prompts for each stage of development
- TDD principles and Git workflow integration

## Sample Project Artifacts

Examine the [sample artifacts](/docs/pbd/sample/) to see a complete prompt-based development cycle for a Todo Application:

- `spec.md` - Initial project specification
- `blueprint.md` - Technical implementation blueprint
- `components.mmd` - Component diagram
- `prompt_plan.md` - Implementation prompt plan
- `todo.md` - Task breakdown with unique identifiers

## License

[MIT License](LICENSE)