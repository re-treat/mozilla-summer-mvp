import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/models/brain.dart';
import 'package:retreatapp/models/exercise.dart';
import 'package:retreatapp/components/httpUtil.dart' as httpUtil;

class EmotionFilterEntry {
  const EmotionFilterEntry(this.name);
  final String name;
}

class EmotionFilter extends StatefulWidget {
  final Brain brain;
  EmotionFilter({this.brain});
  EmotionFilterState state;

  @override
  State createState() => state = EmotionFilterState();

  List<String> get selectedFilters {
    return state.selectedFilters;
  }
}

class EmotionFilterState extends State<EmotionFilter> {
  Set<Exercise> recommendedExercises = Set<Exercise>();

  List<String> _filters = <String>[];

  List<String> get selectedFilters {
    return _filters;
  }

  Stream<Widget> get emotionWidgets async* {
    List<EmotionFilterEntry> _emotion = <EmotionFilterEntry>[];
    await httpUtil.getLabels("q1").then((labels) => {
      labels.forEach((label) => {
        _emotion.add(EmotionFilterEntry(label)),
      }),
    });
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
    return FutureBuilder<List<Widget>>(
      future: emotionWidgets.toList(),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot){
        if(snapshot.hasData){
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Wrap(
                  spacing:  kSpacing,
                  runSpacing: kRunSpacing,
                  children: snapshot.data,
                )
              ]
          );
        }
        else if(snapshot.hasError){
          print(snapshot.error);
          return Text(
            'Error loading labels.',
            textAlign: TextAlign.center,
          );
        }
        else{
          return Text(
            'Loading labels...',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
