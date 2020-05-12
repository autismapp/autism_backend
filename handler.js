
const serverlessHttp = require('serverless-http');
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: 'Autism',
});
const app = express();
app.use(cors());
app.use(bodyParser.json());

app.get('/activity-type', (request, response) => {
  connection.query('SELECT * FROM activity_type', (err,data) => {
    if (err){
      console.log('Error from MySql', err);
      response.status(500).send(err);
    } else {
      response.status(200).send(data);
    }
  });
});

module.exports.app = serverlessHttp(app);