const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/', (req, res) => {
  res.json({ 
    message: 'SecurePay Backend API',
    version: '1.0.0',
    status: 'running'
  });
});

// Login route
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  
  // Dummy response for now
  res.json({
    success: true,
    message: 'Login successful',
    user: {
      id: 12345,
      username: username || 'demo_user',
      email: 'demo@securepay.com',
      role: 'customer'
    },
    token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.dummy_token',
    expiresIn: '24h'
  });
});

// Pay route
app.post('/pay', (req, res) => {
  const { amount, recipient, description } = req.body;
  
  // Dummy response for now
  res.json({
    success: true,
    message: 'Payment processed successfully',
    transaction: {
      id: 'TXN_' + Date.now(),
      amount: amount || 100.00,
      recipient: recipient || 'demo_recipient',
      description: description || 'Payment transaction',
      status: 'completed',
      timestamp: new Date().toISOString(),
      fee: 2.50,
      net_amount: (amount || 100.00) - 2.50
    }
  });
});

// Account information route
app.get('/account-information', (req, res) => {
  // Dummy response for now
  res.json({
    success: true,
    account: {
      id: 'ACC_12345',
      holder_name: 'John Doe',
      account_number: '****1234',
      balance: 2500.75,
      currency: 'USD',
      account_type: 'checking',
      status: 'active',
      created_at: '2023-01-15T10:30:00Z',
      last_transaction: {
        id: 'TXN_98765',
        amount: -50.00,
        description: 'Online purchase',
        timestamp: '2025-07-12T08:15:00Z'
      },
      monthly_limit: 5000.00,
      available_limit: 2500.00
    }
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: 'Something went wrong!',
    error: process.env.NODE_ENV === 'development' ? err.message : 'Internal server error'
  });
});

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({
    success: false,
    message: 'Route not found'
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 SecurePay Backend running on port ${PORT}`);
  console.log(`📍 Available routes:`);
  console.log(`   GET  /                    - API info`);
  console.log(`   POST /login              - User login`);
  console.log(`   POST /pay                - Process payment`);
  console.log(`   GET  /account-information - Get account info`);
});

module.exports = app;
