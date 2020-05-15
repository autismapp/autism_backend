
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
  connection.query('SELECT * FROM activity_type', (err, data) => {
    if (err) {
      console.log('Error from MySql', err);
      response.status(500).send(err);
    } else {
      response.status(200).send(data);
    }
  });
});
app.get('/activity', (request, response) => {
  connection.query('SELECT a.*, at.image_url FROM activity a INNER JOIN activity_type at ON a.activity_type_id = at.activity_type_id', (err, data) => {
    if (err) {
      console.log('Error from MySql', err);
      response.status(500).send(err);
    } else {
      response.status(200).send(data);
    }
  });
});
app.put('/activity/:id', (request, response) => {
  const id = request.params.id;
  const data = request.body;
  // Write an SQL query to update the fields provided in the request for the task WHERE TaskId = id
  // Remember to escape user-provided values
  // Send back 200 (not the updated task)
  connection.query(`UPDATE activity SET Completed = ${data.completed} WHERE activity_id = ${id}`, (err) => {
    if (err) {
      console.log('Error from MySql', err);
      response.status(500).send(err);
    } else {
      response
        .status(200)
        .send(`Updated actvity with ID ${id} and data ${JSON.stringify(data)}`);
    }
  });
});

app.post('/activity/', (request, response) => {
  const data = request.body;
  connection.query(`INSERT INTO activity (user_id, activity_type_id, completed) VALUES (1, ${data.activity_type_id}, 0)`, (err, results) => {
    if (err) {
      response.status(500).send(err);
    } else {
      connection.query(
        `SELECT * FROM activity WHERE activity_id = ${results.insertId}`,
        (error, res) => {
          if (err) {
            console.log('Error from MySQL', error);
            response.status(500).send(err);
          } else {
            response.status(201).send(res[0]);
          }
        }
      );
    }
  });
});



app.delete('/activity/:id', (request, response)=>{
  const id = request.params.id;
  const data = request.body;
  connection.query(`DELETE FROM activity WHERE activity_id = ${id}`, (err)=>{
    if (err) {
      console.log('Error from MySql', err);
      response.status(500).send(err);
    } else{
      response.status(200).send(`Deleted activity with ID: ${id}`)
    }
  })
});


app.get('/feeling/', (request, response)=>{
  const data = request.body;
  connection.query('SELECT * FROM activity_type', (err,data) =>{
    if(err){
      console.log('Error from Mysql', err);
      response.status(500).send(err);
    }else{
      response.status(200).send(data);
    }
  });
});


module.exports.app = serverlessHttp(app);