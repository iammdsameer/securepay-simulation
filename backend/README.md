# SecurePay Backend

A Node.js Express backend API for the SecurePay application.

## Features

- Express.js server running on port 3000
- CORS enabled for cross-origin requests
- Helmet for security headers
- Environment variable support
- Three main API routes with dummy responses

## API Endpoints

### Base URL: `http://localhost:3000`

### Routes

#### 1. Root Route
- **GET** `/`
- Returns API information and status

#### 2. Login
- **POST** `/login`
- Body: `{ "username": "string", "password": "string" }`
- Returns user information and JWT token (dummy)

#### 3. Pay
- **POST** `/pay`
- Body: `{ "amount": number, "recipient": "string", "description": "string" }`
- Returns transaction details (dummy)

#### 4. Account Information
- **GET** `/account-information`
- Returns account details and balance (dummy)

## Installation

```bash
# Install dependencies
npm install

# Install nodemon for development
npm install -g nodemon
```

## Running the Application

```bash
# Development mode (with auto-reload)
npm run dev

# Production mode
npm start
```

## Environment Variables

Create a `.env` file in the backend directory:

```env
NODE_ENV=development
PORT=3000
```

## Example API Calls

### Login
```bash
curl -X POST http://localhost:3000/login \
  -H "Content-Type: application/json" \
  -d '{"username": "testuser", "password": "testpass"}'
```

### Pay
```bash
curl -X POST http://localhost:3000/pay \
  -H "Content-Type: application/json" \
  -d '{"amount": 150.00, "recipient": "john@example.com", "description": "Payment for services"}'
```

### Account Information
```bash
curl -X GET http://localhost:3000/account-information
```

## Dependencies

- **express**: Web framework
- **cors**: Cross-origin resource sharing
- **helmet**: Security middleware
- **dotenv**: Environment variable loader
- **nodemon**: Development auto-reload (dev dependency)

## Security Features

- Helmet middleware for security headers
- CORS configuration
- Input validation ready
- Error handling middleware
- Environment variable protection
