# AI Prompts for Test-Driven Development

This directory contains prompts designed to guide the development process using AI assistants. Effective prompts are crucial for consistent, high-quality output when using a prompt-based development workflow.

## Prompt Structure

For task-based TDD development, structure your prompts with these components:

1. **Context Section** - Provide background and current project state
2. **Task Definition** - Define the specific task with its ID (e.g., [PROJECT]-1.2.3)
3. **Test Requirements** - Specify test scenarios that should be created
4. **Implementation Requirements** - Detail what the implementation should accomplish
5. **Acceptance Criteria** - List conditions that must be met for the task to be complete

## Example Prompt Template

```markdown
# Task [PROJECT]-1.2.3: Implement User Authentication

## Context
We're building a web application using [framework] and [language]. The application needs user authentication. We've already set up the database models and basic routing.

## Test Requirements
Write tests for:
1. User login with valid credentials
2. User login with invalid credentials
3. Password validation (minimum length, special characters)
4. Session management after successful login

## Implementation Requirements
Create:
1. An authentication service that handles login/logout
2. Form validation for the login form
3. Session management using [chosen approach]
4. Integration with our existing user model

## Acceptance Criteria
- All tests must pass
- Login attempts are properly logged
- Failed login attempts trigger appropriate user feedback
- Successful login redirects to the dashboard
- Implementation follows our project's security standards
```

## Best Practices

1. **Be specific** - Clearly define what you want the AI to focus on
2. **Include context** - Provide enough project background for informed suggestions
3. **Reference existing code** - When applicable, refer to relevant existing code
4. **Specify test cases** - Explicitly list test scenarios to ensure coverage
5. **Use consistent terminology** - Match terms used elsewhere in your project
6. **Break into sub-tasks** - For complex features, create a series of smaller prompts

## Task-Based Prompting

When using task-based development:

1. Create one prompt file per task ID
2. Name files consistently: `[PROJECT]-X.Y.Z-short-name.md`
3. Include the task ID in the prompt content
4. Reference dependencies between tasks when necessary
5. Keep the focus narrow to produce testable, manageable code units

## Iterative Refinement

Don't be afraid to iterate on prompts:

1. Start with a basic prompt
2. Evaluate the AI's response
3. Refine the prompt to address any gaps or misunderstandings
4. Document successful prompts for reuse in similar situations

Add your project-specific prompts to this directory as you develop.