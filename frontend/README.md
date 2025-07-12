# SecurePay - React Application

A modern, secure payment processing interface built with React, TypeScript, and shadcn/ui components.

## Features

- 🔐 **Secure Payment Form** - Clean, professional interface for payment processing
- 🎨 **Modern UI** - Built with shadcn/ui components and Tailwind CSS
- 📱 **Responsive Design** - Works seamlessly on desktop and mobile
- ⚡ **Fast Development** - Powered by Vite for instant hot reloading
- 🔍 **TypeScript** - Full type safety and better development experience

## Tech Stack

- **React 19** - Latest React with modern features
- **TypeScript** - Type-safe development
- **Vite** - Fast build tool and development server
- **Tailwind CSS** - Utility-first CSS framework
- **shadcn/ui** - High-quality, accessible UI components
- **ESLint** - Code quality and consistency

## Getting Started

### Prerequisites

- Node.js 18+ 
- npm or yarn

### Installation

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

## Development

The development server will start on `http://localhost:5173` (or next available port).

### Project Structure

```
src/
├── components/          # Reusable UI components
│   ├── Button.tsx      # Custom button component
│   ├── Card.tsx        # Card components
│   └── Input.tsx       # Input component
├── lib/                # Utility functions
│   └── utils.ts        # Tailwind utility functions
├── App.tsx             # Main application component
├── main.tsx            # Application entry point
└── index.css           # Global styles with Tailwind
```

### Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint

### Adding New Components

This project uses shadcn/ui patterns. To add new components:

1. Create component files in `src/components/`
2. Use the `cn()` utility for conditional styling
3. Follow TypeScript interfaces for props
4. Import and use in your application

### Styling

- Uses Tailwind CSS for utility-first styling
- Custom CSS variables for theme colors
- Responsive design with mobile-first approach
- Dark mode support built-in

## Security Considerations

- Form validation on client-side
- Secure input patterns for payment fields
- No sensitive data logged to console
- Proper error handling implemented
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```

You can also install [eslint-plugin-react-x](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-x) and [eslint-plugin-react-dom](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-dom) for React-specific lint rules:

```js
// eslint.config.js
import reactX from 'eslint-plugin-react-x'
import reactDom from 'eslint-plugin-react-dom'

export default tseslint.config([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      // Other configs...
      // Enable lint rules for React
      reactX.configs['recommended-typescript'],
      // Enable lint rules for React DOM
      reactDom.configs.recommended,
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```
