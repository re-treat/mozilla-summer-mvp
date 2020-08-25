import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:retreatapp/models/exercise.dart';
import 'package:retreatapp/components/httpUtil.dart' as httpUtil;

import '../constants.dart';

class Brain extends ChangeNotifier {
  Map<int, String> _answers = new Map();
  Set<String> currentEmotions = Set<String>();
  Set<String> causesOfEmotion = Set<String>();
  Set<String> desiredEmotions = Set<String>();

  void updateCurrentEmotions(List<String> answers) {
    currentEmotions = Set<String>();
    answers.forEach((e) => currentEmotions.add(e));
  }

  void updateCausesOfEmotion(List<String> answers) {
    causesOfEmotion = Set<String>();
    answers.forEach((e) => causesOfEmotion.add(e));
  }

  void updateDesiredEmotions(List<String> answers) {
    desiredEmotions = Set<String>();
    answers.forEach((e) => desiredEmotions.add(e));
  }

  void clearCurrentEmotions(List<String> answers) {
    currentEmotions = Set<String>();
  }

  void clearCausesOfEmotion(List<String> answers) {
    causesOfEmotion = Set<String>();
  }

  void clearDesiredEmotions(List<String> answers) {
    desiredEmotions = Set<String>();
  }

  Future<List<Exercise>> getRecommendExercises() async {
    List<String> labels_q1 = List<String>();
    labels_q1.addAll(currentEmotions);
    List<String> labels_q2 = List<String>();
    labels_q2.addAll(causesOfEmotion);
    List<String> labels_q3 = List<String>();
    labels_q3.addAll(desiredEmotions);
    List<Exercise> result = List<Exercise>();

    await httpUtil.matchExercise(labels_q1, labels_q2, labels_q3, 5).then((exList) => {
      exList.forEach((ex) {
        result.add(exercises[ex]);
      })
    });
    return result;
  }

  UnmodifiableMapView<int, String> get answers {
    return UnmodifiableMapView(_answers);
  }

  int get answerCount {
    return _answers.length;
  }

  void addAnswers(Map<int, String> answers) {
    answers.forEach((key, value) {
      _answers[key] = value;
    });
  }
}
