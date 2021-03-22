import 'dart:convert';
import 'package:localstorage/localstorage.dart';

String utf8convert(String text) {
  List<int> bytes = text
      .toString()
      .codeUnits;
  return utf8.decode(bytes);
}



class ResponseHistory {
  static final LocalStorage storage = new LocalStorage('resp_history');
  static bool hasResponded(String storyId){
      var item = storage.getItem(storyId);
      return storage.getItem(storyId) != null && item as bool;

  }

  static void respond(String storyId) {
    storage.setItem(storyId,true);
  }

}

