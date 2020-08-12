import 'package:flutter/material.dart';
import 'package:retreatapp/components/card_box_decoration.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/exercise.dart';

class ExercisePreview extends StatefulWidget {
  final Exercise exercise;

  const ExercisePreview({this.exercise});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<ExercisePreview> {
  String taskTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: kWidthFactor,
        child: DecoratedBox(
          decoration: cardBoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(72.0, 40.0, 72.0, 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      widget.exercise.name,
                      style: kHeadLineTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(widget.exercise.instructions.toString()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
