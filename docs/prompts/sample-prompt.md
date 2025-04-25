# Task [PROJECT]-1.1.1: Set Up Authentication Service

## Context
We're building a web application using React, TypeScript, and Firebase. We need to implement user authentication to allow users to sign in with email/password and Google OAuth. This is the first step in our user management system.

## Test Requirements
Write tests for:
1. User sign-in with valid email/password
2. User sign-in with invalid credentials
3. User sign-in with Google OAuth
4. User sign-out functionality
5. Protected route redirection for unauthenticated users

## Implementation Requirements
Create:
1. An authentication service that interfaces with Firebase Authentication
2. React context for managing authentication state
3. Custom hooks for accessing user state and authentication methods
4. Sign-in and sign-out functionality
5. Protected route component that redirects unauthenticated users

## Acceptance Criteria
- All tests pass with at least 90% coverage
- Users can sign in with email/password
- Users can sign in with Google OAuth
- Authentication state persists on page reload
- Protected routes correctly redirect unauthenticated users to sign-in page
- User authentication state is accessible throughout the application

## Dependencies
- Firebase project is set up and configured
- React Router is installed and configured with basic routes

## Note to AI Assistant
Please follow TDD principles by writing tests first, then implementing the code that satisfies those tests. Structure the code to be modular and reusable across the application.