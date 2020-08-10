const dbUtil = require("./dbUtil.js");
const express = require('express');
const cors = require("cors");
const bodyParser = require('body-parser');

const app = express();

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Hello World! Welcome to Re:treat')
});

app.post('/addExercise', async (req, res) => {
  const name = req.body.name;
  const file = req.body.file;
  const labels_q1 = req.body.labels_q1;
  const labels_q2 = req.body.labels_q2;
  const labels_q3 = req.body.labels_q3;

  const promise = dbUtil.addExercise(name, file, labels_q1, labels_q2, labels_q3);
  promise.then(function (value) {
    res.status(200);
    res.send("Added Exercise successfully!");
  }, function (value) {
    console.log("error in adding exercise to db");
    res.status(500);
    res.send("Failed to add exercise");
  });
});

app.post('/queryExercise', cors(), async (req, res) => {
  const label = req.body.label;
  const question = req.body.question;

  const promise = dbUtil.queryExercise(label, question);
  promise.then(function (value) {
    console.log(value);
    const exercises_arr = value.map((ex) => ({ [ex]: ex.url }));
    console.log("Queried exercises succesfully!");
    res.status(200);
    res.send(exercises_arr);
  }, function (value) {
    console.log("error in querying db for exercises");
    res.status(500);
    res.send("Failed to add exercise");
  });

});

 app.post('/getLabels', cors(), async(req, res) => {
  const question = req.body.question;
  const promise = dbUtil.getLabels(question);
  promise.then(function (value){
    console.log(value);
    res.status(200);
    res.send(value);
  }).catch(function(err){
    console.log("error getting labels");
    res.status(500);
    res.send("Failed to get labels");
  });
 });

app.listen(8080, () => {
  console.log('Example app listening on port 8080!')
});