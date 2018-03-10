const express = require('express');
// require('env2')('./config.env');

const app = express.Router();

module.exports = [
  app.get('/', (req, res) => {
    res.sendFile('index.html', { root: '/Users/apple/Desktop/Desktop/Maja/AmeMusic/' });
  }),
];
