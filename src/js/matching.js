/*
 * Find the best matching exercises given lables as input
 * @param {string[]} labels
 * @param {int} size: number of exercises to return
 * @returns {string[]} exercises of length size, could have smaller size if there is not enough matching exercises
 */
 function matchExercise(labels, size){
 	if(!Array.isArray(labels)) { throw "Labels has to be in an array." }
 	if(typeof size != "number" || size <= 0) { throw "Invalid size."; }

 	let labelMatch = new Map(); 
 	for(let label of labels){
 		let exercises = getExercise(label);
 		for(let exercise of exercises){
 			if(!labelMatch.has(exercise)){ labelMatch.set(exercise, 0); }
 			labelMatch.set(exercise, labelMatch.get(exercise)+1);
 		}
 	}

 	let exerciseMatch = new Map();
 	for(let [exercise, count] of labelMatch){
 		if(!exerciseMatch.has(count)) { exerciseMatch.set(count, new Array()); }
 		exerciseMatch.get(count).push(exercise);
 	}

 	let counts = new Array();
 	for(let count of exerciseMatch.keys()){ counts.push(count); }

 	let matches = new Array();
 	while(matches.length < size && counts.length > 0){
 		let max = Math.max.apply(null, counts);
 		if(max > 0){
 			let exercises = exerciseMatch.get(max);
 			for(let ex of exercises){
 				matches.push(ex);
 				if(matches.length == size) { return matches; }
 			}
 			counts.splice(counts.indexOf(max), 1);
 		}
 		else{ break; }
 	}
 	return matches;
 }

/* 
 * Dummy function to mock getting exercises from the DB
 * @param {string} label
 * @returns {string[]} exercises
 */
 function getExercise(label){
 	let a = ["e1", "e2"];
 	let b = ["e1", "e2"];
 	let c = ["e1", "e3"];
 	let d = ["e3"];

 	switch(label){
 		case "a": return a;
 		case "b": return b;
 		case "c": return c;
 		case "d": return d;
 		default:  return new Array();
 	}
 }