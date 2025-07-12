<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# SecurePay React Application

This is a React application built with Vite, TypeScript, and shadcn/ui components for secure payment processing.

## Tech Stack
- **React 19** with TypeScript
- **Vite** for fast development and building
- **Tailwind CSS** for styling
- **shadcn/ui** for UI components
- **ESLint** for code quality

## Project Structure
- `src/components/` - Reusable UI components based on shadcn/ui
- `src/lib/` - Utility functions and helpers
- `@/` - Path alias pointing to `src/`

## Development Guidelines
- Use TypeScript for all components and logic
- Follow shadcn/ui patterns for new components
- Use Tailwind CSS for styling
- Implement proper form validation for payment inputs
- Ensure responsive design for mobile and desktop
- Focus on security best practices for payment handling

## Component Patterns
- Use the `cn()` utility for conditional classes
- Follow the shadcn/ui component structure
- Implement proper TypeScript interfaces for props
- Use React hooks appropriately (useState, useEffect, etc.)

## Security Considerations
- Never log sensitive payment information
- Implement client-side validation
- Use secure input patterns for payment fields
- Consider implementing proper error handling
