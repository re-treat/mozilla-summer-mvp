import "package:http/http.dart" as http;
import 'dart:convert';

final host = "https://re-treat.uc.r.appspot.com";

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

/* For debug use
void main() {
  List<String> q1 = ["frustrated"];
  List<String> q2 = [];
  List<String> q3 = [];
  matchExercise(q1, q2, q3, 1).then((value) => {print(value)});

  getLabels("q1").then((value) => {print(value)});
}
*/