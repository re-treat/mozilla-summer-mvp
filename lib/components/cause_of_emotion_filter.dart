import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';

import '../models/brain.dart';
import '../models/exercise.dart';

class CauseOfEmotionFilterEntry {
  const CauseOfEmotionFilterEntry(this.name);
  final String name;
}

class CauseOfEmotionFilter extends StatefulWidget {
  final Brain brain;
  CauseOfEmotionFilter({this.brain});

  @override
  State createState() => CauseOfEmotionFilterState();
}

class CauseOfEmotionFilterState extends State<CauseOfEmotionFilter> {
  Set<Exercise> recommendedExercises = Set<Exercise>();

  final List<CauseOfEmotionFilterEntry> _cause = <CauseOfEmotionFilterEntry>[
    const CauseOfEmotionFilterEntry('work'),
    const CauseOfEmotionFilterEntry('academics'),
    const CauseOfEmotionFilterEntry('financial'),
    const CauseOfEmotionFilterEntry('interpersonal relationships'),
  ];
  List<String> _filters = <String>[];

  Iterable<Widget> get causeOfEmotionWidgets sync* {
    for (final CauseOfEmotionFilterEntry cause in _cause) {
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
              cause.name,
              style: TextStyle(color: kDarkGrayColor),
            ),
          ),
          selected: _filters.contains(cause.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(cause.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == cause.name;
                });
              }
            });
            widget.brain.updateCausesOfEmotion(_filters);
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
          children: causeOfEmotionWidgets.toList(),
        ),
        //        Text('Look for: ${_filters.join(', ')}'),
        //        Text('Total matches: ${getRecommendExercises().length}'),
        //        Text(
        //            'Look for: ${getRecommendExercises().map((e) => e.name).toString()}'),
//        Text('Look for: ${_filters.join(', ')}'),
      ],
    );
  }

  Set<Exercise> getRecommendExercises() {
//    List<Exercise> recommendedExercises = [];
    exercises.forEach((exercise) {
      if (Set.of(_filters)
          .intersection(Set.of(exercise.labelsCauseOfEmotion))
          .isNotEmpty) {
        recommendedExercises.add(exercise);
      }
    });
    return recommendedExercises;
  }
}
