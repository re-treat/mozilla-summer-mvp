import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:retreatapp/models/exercise.dart';

final host = "http://localhost:8081";
//final host = "https://re-treat.uc.r.appspot.com";

Future<List<String>> getLabels(String question) async {
  var url = host+"/getLabels";
  var header = {  'Content-Type': 'application/json; charset=UTF-8' };
  var body = { "question" : question };

  var response = await http.post(url, headers: header, body: jsonEncode(body));
  if(response.statusCode == 200){
    var result = jsonDecode(response.body);
    return result.cast<String>();
  }
  else{ return null; }
}

Future<List<String>> matchExercise(List<String> labels_q1, List<String> labels_q2, List<String> labels_q3, int size) async {
  var url = host+"/matchExercise";
  var header = {  'Content-Type': 'application/json; charset=UTF-8' };
  var body = {
    "labels_q1": labels_q1,
    "labels_q2": labels_q2,
    "labels_q3": labels_q3,
    "size": size
  };

  var response = await http.post(url, headers: header, body: jsonEncode(body));
  if(response.statusCode == 200){
    var result = jsonDecode(response.body);
    return result.cast<String>();
  }
  else{ return null; }
}

Future<Exercise> getExercise(String exerciseId) async{
  var url = host + "/getExercise";
  var header = {  'Content-Type': 'application/json; charset=UTF-8' };
  var body = { "id": exerciseId };

  var response = await http.post(url, headers: header, body: jsonEncode(body));
  if(response.statusCode == 200){
    var result = jsonDecode(response.body);
    String name = result["name"];
    String reference = result["reference"];
    String image = "images/" + result["image"];

    var labels = result["labels_q1"];
    List<String> labels_q1 = List<String>();
    labels.forEach((label) => labels_q1.add(label));

    labels = result["labels_q2"];
    List<String> labels_q2 = List<String>();
    labels.forEach((label) => labels_q2.add(label));

    labels = result["labels_q3"];
    List<String> labels_q3 = List<String>();
    labels.forEach((label) => labels_q3.add(label));

    Exercise exercise = Exercise(exerciseId, name, image, labels_q1, labels_q2, labels_q3);

    exercise.addReference(reference);
    var instructions = result["instructions"];
    instructions.forEach((inst) => {
      exercise.addInstruction(inst["type"], inst["content"])
    });
    return exercise;
  }
  else { return null; }
}

/* For debug use
void main() {
  String id = "directing_kindness_to_yourself";
  getExercise(id).then((value) => {print(value)});
}
*/