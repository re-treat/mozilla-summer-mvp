import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/components/httpUtil.dart' as httpUtil;

import '../models/brain.dart';
import '../models/exercise.dart';

class DesiredEmotionFilterEntry {
  const DesiredEmotionFilterEntry(this.name);
  final String name;
}

class DesiredEmotionFilter extends StatefulWidget {
  final Brain brain;
  DesiredEmotionFilter({this.brain});

  DesiredEmotionFilterState state;

  @override
  State createState() => state = DesiredEmotionFilterState();

  List<String> get selectedFilters {
    return state.selectedFilters;
  }
}

class DesiredEmotionFilterState extends State<DesiredEmotionFilter> {
  Set<Exercise> recommendedExercises = Set<Exercise>();
  List<String> _filters = <String>[];

  List<String> get selectedFilters {
    return _filters;
  }

  Stream<Widget> get emotionWidgets async* {
    List<DesiredEmotionFilterEntry> _emotion = <DesiredEmotionFilterEntry>[];
    await httpUtil.getLabels("q3").then((labels) => {
      labels.forEach((label) => {
        _emotion.add(DesiredEmotionFilterEntry(label)),
      }),
    });
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
