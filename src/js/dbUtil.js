const fbConfig = require("./fbConfig.js");

var firebase = require("firebase/app");
require("firebase/firestore");
firebase.initializeApp(fbConfig);
var db = firebase.firestore();

/*
 * Adds the exercise to the db
 * @param{string} name: name of the exercise, should be in the format of name_of_the_exercise
 * @param{string} file: filename of the exercise page, e.g: "index.html"
 * @param{string[]} labels_q1: array of labels as strings for question 1
 * @param{string[]} labels_q2: array of labels as strings for question 2
 * @param{string[]} labels_q3: array of labels as strings for question 3
 */
 function addExercise(name, file, labels_q1, labels_q2, labels_q3){
	if(!Array.isArray(labels_q1) || !Array.isArray(labels_q2) || !Array.isArray(labels_q3)) { 
		console.error("Invalid label input");
		return;
	}

	// Add exersice to the db
	let exerciseRef = db.collection("exercises").doc(name);
	let status = exerciseRef.get().then(function(doc){
		if(doc.exists) { throw "Exercise already exists"; }
		else{ 
			exerciseRef.set( {url: file} ); 
			// Add exercise to q1 labels
			const q1Ref = db.collection("labels_q1");
			labels_q1.forEach(function(label) {
				let labelRef = q1Ref.doc(label);
				labelRef.get().then(function(doc){
					let field = new Object();
					field[name] = true;

					if(doc.exists){
						labelRef.set(field, {merge: true}); 
					}
					else{ 
						labelRef.set(field); 
					}
				}).catch(function(error){ 
					throw error;
				});
			});

			// Add exercise to q2 labels
			const q2Ref = db.collection("labels_q2");
			labels_q2.forEach(function(label) {
				let labelRef = q2Ref.doc(label);
				labelRef.get().then(function(doc){
					let field = new Object();
					field[name] = true;

					if(doc.exists){
						labelRef.set(field, {merge: true}); 
					}
					else{ 
						labelRef.set(field); 
					}
				}).catch(function(error){ 
					throw error;
				});
			});

			// Add exercise to q3 labels
			const q3Ref = db.collection("labels_q3");
			labels_q3.forEach(function(label) {
				let labelRef = q3Ref.doc(label);
				labelRef.get().then(function(doc){
					let field = new Object();
					field[name] = true;

					if(doc.exists){
						labelRef.set(field, {merge: true}); 
					}
					else{ 
						labelRef.set(field); 
					}
				}).catch(function(error){ 
					throw error;
				});
			});
		}
	}).catch(function(err){ 
		console.error(err); 
	});
}

async function queryExercise(label, question, result){
	if(!Array.isArray(result)) {
		console.error("Result is not an array.");
	}
	switch(question) {
		case "q1": 
			await db.collection("labels_q1").doc(label).get().then(function(doc){ 
				let data = doc.data(); 
				for(let ex of Object.keys(data)){ result.push(ex); }
			});
			break;
		case "q2":
			await db.collection("labels_q2").doc(label).get().then(function(doc){ 
				let data = doc.data(); 
				for(let ex of Object.keys(data)){ result.push(ex); }
			});
			break;
		case "q3":
			await db.collection("labels_q3").doc(label).get().then(function(doc){ 
				let data = doc.data(); 
				for(let ex of Object.keys(data)){ result.push(ex); }
			});
			break;
		default: 
			console.error("Invalid question input");
	}
}

module.exports = { addExercise, queryExercise }
