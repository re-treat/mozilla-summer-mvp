const fbConfig = require("./fbConfig.js");

var firebase = require("firebase/app");
require("firebase/firestore");
firebase.initializeApp(fbConfig);
var db = firebase.firestore();

db.collection("labels-q1").get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        console.log(`${doc.id} => ${doc.data()}`);
    });
});

