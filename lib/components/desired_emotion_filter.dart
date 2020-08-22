import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';

import '../models/brain.dart';
import '../models/exercise.dart';

class DesiredEmotionFilterEntry {
  const DesiredEmotionFilterEntry(this.name);
  final String name;
}

class DesiredEmotionFilter extends StatefulWidget {
  final Brain brain;
  DesiredEmotionFilter({this.brain});

  @override
  State createState() => DesiredEmotionFilterState();
}

class DesiredEmotionFilterState extends State<DesiredEmotionFilter> {
  Set<Exercise> recommendedExercises = Set<Exercise>();

  final List<DesiredEmotionFilterEntry> _emotion = <DesiredEmotionFilterEntry>[
    const DesiredEmotionFilterEntry('confident'),
    const DesiredEmotionFilterEntry('motivated'),
    const DesiredEmotionFilterEntry('relaxed'),
    const DesiredEmotionFilterEntry('relieved'),
    const DesiredEmotionFilterEntry('thankful'),
  ];
  List<String> _filters = <String>[];

  Iterable<Widget> get emotionWidgets sync* {
    for (final DesiredEmotionFilterEntry emotion in _emotion) {
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
              } else {
                _filters.removeWhere((String name) {
                  return name == emotion.name;
                });
              }
            });
            widget.brain.updateDesiredEmotions(_filters);
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
        //  Text('Look for: ${_filters.join(', ')}'),
      ],
    );
  }

  Set<Exercise> getRecommendExercises() {
//    List<Exercise> recommendedExercises = [];
    exercises.forEach((exercise) {
      if (Set.of(_filters)
          .intersection(Set.of(exercise.labelsEffectAndGoal))
          .isNotEmpty) {
        recommendedExercises.add(exercise);
      }
    });
    return recommendedExercises;
  }
}
