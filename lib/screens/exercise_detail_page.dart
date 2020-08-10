import 'package:flutter/material.dart';
import 'package:retreatapp/components/bottom_button.dart';
import 'package:retreatapp/components/reusable_card.dart';
import 'package:retreatapp/screens/input_page.dart';
import 'package:retreatapp/components/exercise_description.dart';

import '../constants.dart';

class ExerciseDetailPage extends StatelessWidget {
  final String exerciseId;

  ExerciseDetailPage({
    @required this.exerciseId,
  }){
    this.exercise = exercise_description[exerciseId];
  }

  // create Exercise class object
  Map<String, String> exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EXERCISE DETAIL',
          style: kHeadLineTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kLightBlueColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(exercise['name'], style: kBodyLargeTextStyle),
                  Text(
                    exercise['instructions'],
                    textAlign: TextAlign.center,
                    style: kBodyRegularTextStyle,
                  ),
                  Text(
                    exercise['why_it_works'],
                    textAlign: TextAlign.center,
                    style: kBodyRegularTextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(),
                ),
              );
            },
            buttonTitle: 'START OVER',
          )
        ],
      ),
    );
  }
}
