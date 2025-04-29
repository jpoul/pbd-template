# Git Workflow Strategy for Prompt-Based Development

This document outlines a Git workflow strategy that integrates with a task-oriented, TDD-focused development approach using AI prompts.

## Setup Checklist

1. [ ] **Create Initial Branch Structure**
   - [ ] Create `main` branch for stable releases
   - [ ] Create `develop` branch for day-to-day development
   - [ ] Set up branch protection rules

2. [ ] **Configure Git Commit Template**
   - [ ] Install git-commit-template.txt as the commit template:
     ```
     git config --local commit.template ./.tools/git-templates/git-commit-template.txt
     ```
   - [ ] Ensure all team members are using the template

3. [ ] **Set Up Git Hooks**
   - [ ] Create pre-commit hook for running tests
   - [ ] Create pre-commit hook for ensuring code coverage
   - [ ] Add commit-msg hook for enforcing commit message format

## Development Process Checklist

1. [ ] **Feature Branch Creation**
   - [ ] Create feature branch for each major task section
   - [ ] Name branches using convention: `feature/zeno-X.Y.Z-short-description`
   - [ ] Base feature branches off the `develop` branch

2. [ ] **Task-Based Commits**
   - [ ] Write tests first (following TDD)
   - [ ] Commit tests with message: `[zeno-X.Y.Z] Add tests for [feature]`
   - [ ] Implement code to pass tests
   - [ ] Commit implementation with message: `[zeno-X.Y.Z] Implement [feature]`
   - [ ] Refactor if needed with message: `[zeno-X.Y.Z] Refactor [feature]`

3. [ ] **Todo Management**
   - [ ] Update todo.md after completing each task by marking it as done
   - [ ] Include todo updates in the same commit as the implementation

4. [ ] **Pull Request Process**
   - [ ] Create PR when a task section is complete
   - [ ] Reference the specific task ID(s) completed (e.g., "Completes zeno-1.1.2")
   - [ ] Ensure all tests pass in CI
   - [ ] Get approval before merging

5. [ ] **Milestone Tagging**
   - [ ] When all tasks in a phase are complete, run the milestone tagging script:
     ```
     ./.tools/git-templates/create-milestone-tag.sh v0.1-phase1 "Phase Name" "Description of achievements"
     ```
   - [ ] Use semantic versioning with phase reference (e.g., `v0.1-phase1`, `v0.2-phase2`)
   - [ ] Push the tag to the remote repository:
     ```
     git push origin v0.1-phase1
     ```
   - [ ] Consider creating a GitHub release based on this tag
   - [ ] Update project documentation to reflect the milestone completion

## Automation Opportunities

1. [ ] **Todo Automation Script**
   - [ ] Create script to mark items complete in todo.md based on commit messages
   - [ ] Run script as part of commit process

2. [ ] **PR Template**
   - [ ] Create PR template that includes task references
   - [ ] Add test coverage report section
   - [ ] Add reviewer checklist based on TDD requirements

3. [ ] **CI/CD Integration**
   - [ ] Set up GitHub Actions to run tests on PR
   - [ ] Configure deployment to development environment on merge to `develop`
   - [ ] Configure deployment to production on merge to `main`

## Example Commit Message

```
[zeno-1.1.2] Implement authentication

# Detailed description of changes (what and why)
- Add authentication utility functions
- Configure OAuth providers
- Update documentation with authentication flow

# Reference
Task: zeno-1.1.2
Prompt: 1.2
Tests: 5 new, all passing
Coverage: 94%
```

## Example Branch Naming

```
feature/zeno-1.1.2-auth-implementation
feature/zeno-2.3.2-signup-components
feature/zeno-4.8.1-state-management
```

Replace `zeno` with your specific project identifier throughout this document.