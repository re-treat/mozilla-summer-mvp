import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:retreatapp/models/exercise.dart';

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

  Set<Exercise> getRecommendExercises() {
    Set<Exercise> recommendedExercises = Set<Exercise>();

    exercises.forEach((exercise) {
      if (currentEmotions
          .intersection(Set.of(exercise.labelsTargetEmotion))
          .isNotEmpty) {
        recommendedExercises.add(exercise);
      }
      if (causesOfEmotion
          .intersection(Set.of(exercise.labelsCauseOfEmotion))
          .isNotEmpty) {
        recommendedExercises.add(exercise);
      }
      if (desiredEmotions
          .intersection(Set.of(exercise.labelsEffectAndGoal))
          .isNotEmpty) {
        recommendedExercises.add(exercise);
      }
    });
    return recommendedExercises;
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
