# Task-Oriented Prompts for Todo Application

## **Phase 1: Project Setup and Infrastructure**

### **Step 1: Project Initialization**

#### **Prompt 1.1: React TypeScript Project Setup**
```text
I am building a Todo application using React, TypeScript, and Firebase. Please help me create a new project with Vite. Provide:

1. The exact command to create a new Vite project with React and TypeScript
2. Essential dependencies to install (React Router, Firebase, Tailwind CSS)
3. Initial folder structure recommendations for a well-organized Todo application
4. Configuration for TypeScript, ESLint, and Prettier optimized for React development

The project will be a full-featured Todo application with authentication, real-time updates, and multiple views.
```

#### **Prompt 1.2: Firebase Configuration**
```text
For my Todo application, I need to set up Firebase services. Please provide:

1. Step-by-step instructions to create a new Firebase project
2. Commands to install Firebase SDK and initialize the project
3. Configuration setup for Firebase Authentication and Firestore
4. Security best practices for the initial Firebase setup
5. TypeScript type definitions for my Firebase models

I need to support email/password authentication, Google sign-in, and store todo data with real-time updates.
```

### **Step 2: Core Application Structure**

#### **Prompt 2.1: Routing and Layout Setup**
```text
I'm implementing the core structure for my Todo application with React Router and Tailwind CSS. Please provide:

1. A complete React Router v6 setup with routes for:
   - Authentication pages (login, register, password reset)
   - Dashboard/Todo list
   - Todo details/editing
   - User profile
   - Calendar view
2. A responsive layout component structure with:
   - Header with navigation and user status
   - Sidebar for categories/filters
   - Main content area
   - Footer with app information
3. Tailwind CSS configuration for consistent styling

Include TypeScript interfaces and proper route protection for authenticated routes.
```

## **Phase 2: Authentication System**

### **Step 3: User Authentication**

#### **Prompt 3.1: Firebase Authentication Context**
```text
I need to implement a complete authentication system with Firebase for my Todo app. Please provide:

1. A React context setup for authentication state management
2. Custom hooks for auth operations (login, register, logout, password reset)
3. Protected route component implementation
4. Persistence handling for user sessions
5. Loading and error states for authentication processes

Ensure type safety with TypeScript and include comments explaining key implementation details.
```

#### **Prompt 3.2: Authentication UI Components**
```text
I need to create UI components for my Todo app's authentication system. Please provide:

1. A responsive login form component with:
   - Email/password fields with validation
   - "Remember me" functionality
   - Google sign-in button
   - Link to password reset
2. A registration form with:
   - Email, password, and password confirmation
   - Terms acceptance checkbox
   - Validation logic
3. A password reset flow

Use Tailwind CSS for styling and include form validation with error messages.
```

## **Phase 3: Todo Management Core Functionality**

### **Step 5: Todo Data Model**

#### **Prompt 5.1: Firestore Data Model Implementation**
```text
I need to design and implement the Firestore data model for my Todo application. Please provide:

1. Firestore collection and document structure for:
   - Users
   - Todos with various fields (title, description, due date, status, priority, etc.)
   - Categories
2. TypeScript interfaces for all data models
3. Firestore security rules for proper access control
4. Index recommendations for efficient queries

Ensure the model supports features like filtering, sorting, and real-time updates.
```

#### **Prompt 5.2: Todo CRUD Service**
```text
I need a complete CRUD service for managing todos in my Firebase application. Please provide:

1. A TodoService class with methods for:
   - Creating new todos
   - Reading todos with various filters
   - Updating todo properties
   - Deleting todos
   - Batch operations
2. Real-time listener setup for todo changes
3. Error handling and data validation
4. Optimistic UI update patterns for better UX

Use TypeScript for type safety and implement proper error handling.
```

### **Step 6: Todo List Interface**

#### **Prompt 6.1: Todo List Component**
```text
I'm implementing the main Todo list component for my application. Please provide:

1. A responsive Todo list component with:
   - Filtering capabilities (by status, due date, priority, category)
   - Sorting options
   - Search functionality
   - List and grid view options
2. Skeleton loading states for asynchronous data
3. Empty state and error handling UI
4. Virtual scrolling for performance with large lists

Use React hooks for state management and ensure the component is performant with large datasets.
```

## **Phase 4: Organization and Productivity Features**

### **Step 9: Calendar View**

#### **Prompt 9.1: Calendar Implementation**
```text
I need to implement a calendar view for my Todo application. Please provide:

1. A component that displays todos on a calendar based on due dates
2. Month, week, and day view implementations
3. Todo drag-and-drop functionality for rescheduling
4. Visual indicators for todo priority and completion status
5. Integration with the existing Todo data service

The calendar should be responsive and work well on both desktop and mobile devices.
```

## **Phase 5: Performance and Deployment**

### **Step 12: Final Deployment**

#### **Prompt 12.1: Firebase Hosting Deployment**
```text
I'm ready to deploy my Todo application to Firebase Hosting. Please provide:

1. Pre-deployment checklist for a production React application
2. Firebase Hosting configuration for a React SPA
3. CI/CD setup with GitHub Actions for automatic deployment
4. Post-deployment verification steps
5. Monitoring and analytics setup

Include considerations for environment variables, caching strategies, and performance optimization.
```

---

*Note: This prompt plan contains selected prompts from each phase of development. In a real implementation, you would have additional prompts covering all steps outlined in the blueprint document.*