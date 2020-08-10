import 'dart:core';

import 'package:flutter/material.dart';
import 'package:retreatapp/components/bottom_button.dart';
import 'package:retreatapp/components/reusable_question_card.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/screens/results_page.dart';
import 'package:retreatapp/components/httpUtil.dart' as httpUtil;

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final questions = [
    'How are you feeling?',
    'What is causing you to feel this way?',
    'How do you want to feel?'
  ];

  var myFeelingsChoices = [];
  var causeOfFeelingChoices = [];
  var desiredFeelingChoices = [];

  _InputPageState() {
    httpUtil.getLabels("q1").then((labels) => {
      labels.forEach((label) => {
        myFeelingsChoices.add({
          "display": label,
          "value": label,
        })
      })
    });

    httpUtil.getLabels("q2").then((labels) => {
      labels.forEach((label) => {
        causeOfFeelingChoices.add({
          "display": label,
          "value": label,
        })
      })
    });

    httpUtil.getLabels("q3").then((labels) => {
      labels.forEach((label) => {
        desiredFeelingChoices.add({
          "display": label,
          "value": label,
        })
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ReTreat Questionnaire',
          style: kHeadLineTextStyle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: ReusableQuestionCard(
              question: questions[0],
              choices: myFeelingsChoices,
            ),
          ),
          Expanded(
            flex: 3,
            child: ReusableQuestionCard(
              question: questions[1],
              choices: causeOfFeelingChoices,
            ),
          ),
          Expanded(
            flex: 3,
            child: ReusableQuestionCard(
              question: questions[2],
              choices: desiredFeelingChoices,
            ),
          ),
          BottomButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    recommendedExercises: [""],
                  ),
                ),
              );
            },
            buttonTitle: 'SHOW RECOMMENDATIONS',
          ),
        ],
      ),
    );
  }
}
