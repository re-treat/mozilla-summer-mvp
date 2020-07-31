const fbConfig = require("./fbConfig.js");

var firebase = require("firebase/app");
require("firebase/firestore");
firebase.initializeApp(fbConfig);
var db = firebase.firestore();


/*
 * Adds the exercise to the db
 * @param{string} name: name of the exercise, should be in the format of name-of-the-exercise
 * @param{string[]} labels_q1: array of labels as strings for question 1
 * @param{string[]} labels_q2: array of labels as strings for question 2
 * @param{string[]} labels_q3: array of labels as strings for question 3
 */
function addExercise(name, labels_q1, labels_q2, labels_q3){
}


