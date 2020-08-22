import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/models/brain.dart';
import 'package:retreatapp/models/exercise.dart';

class EmotionFilterEntry {
  const EmotionFilterEntry(this.name);
  final String name;
}

class EmotionFilter extends StatefulWidget {
  final Brain brain;
  EmotionFilter({this.brain});

  @override
  State createState() => EmotionFilterState();
}

class EmotionFilterState extends State<EmotionFilter> {
  Set<Exercise> recommendedExercises = Set<Exercise>();

  final List<EmotionFilterEntry> _emotion = <EmotionFilterEntry>[
//    const EmotionFilterEntry('angry'),
    const EmotionFilterEntry('disappointed'),
    const EmotionFilterEntry('frustrated'),
    const EmotionFilterEntry('guilty'),
//    const EmotionFilterEntry('impatient'),
    const EmotionFilterEntry('paralyzed'),
    const EmotionFilterEntry('pessimistic'),
    const EmotionFilterEntry('regretful'),
    const EmotionFilterEntry('self-conscious'),
    const EmotionFilterEntry('stressed'),
    const EmotionFilterEntry('vulnerable'),
    const EmotionFilterEntry('worried'),
  ];
  List<String> _filters = <String>[];

  Iterable<Widget> get emotionWidgets sync* {
    for (final EmotionFilterEntry emotion in _emotion) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          elevation: 2.0,
          pressElevation: 0.0,
          selectedColor: kLightBlueColor,
          backgroundColor: kLightGrayColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          label: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Text(
              emotion.name,
              style: TextStyle(color: kDarkGrayColor),
            ),
          ),
          selected: _filters.contains(emotion.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(emotion.name);
//                widget.answers.addAnswer(emotion.name);
              } else {
                _filters.removeWhere((String name) {
//                  widget.answers.deleteAnswer(emotion.name);
                  return name == emotion.name;
                });
              }
            });
            widget.brain.updateCurrentEmotions(_filters);
//            recommendedExercises = getRecommendExercises();
//            recommendedExercises.forEach((exercise) {
//              widget.brain.recommendedExercises.add(exercise);
//            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          spacing: kSpacing,
          runSpacing: kRunSpacing,
          children: emotionWidgets.toList(),
        ),
//        Text('Look for: ${_filters.join(', ')}'),
//        Text('Total matches: ${getRecommendExercises().length}'),
//        Text(
//            'Look for: ${getRecommendExercises().map((e) => e.name).toString()}'),
      ],
    );
  }

  Set<Exercise> getRecommendExercises() {
//    List<Exercise> recommendedExercises = [];
    exercises.forEach((exercise) {
      if (Set.of(_filters)
          .intersection(Set.of(exercise.labelsTargetEmotion))
          .isNotEmpty) {
        recommendedExercises.add(exercise);
      }
    });
    return recommendedExercises;
  }
}
