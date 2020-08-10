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

  ReusableQuestionCard form_q1;
  ReusableQuestionCard form_q2;
  ReusableQuestionCard form_q3;

  _InputPageState() {
    // Fetch available labels from the server
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
    // Construct the forms
    form_q1 = ReusableQuestionCard(
      question: questions[0],
      choices: myFeelingsChoices,
    );
    form_q2 = ReusableQuestionCard(
      question: questions[1],
      choices: causeOfFeelingChoices,
    );
    form_q3 = ReusableQuestionCard(
      question: questions[2],
      choices: desiredFeelingChoices,
    );
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
            child: form_q1
          ),
          Expanded(
            flex: 3,
            child: form_q2
          ),
          Expanded(
            flex: 3,
            child: form_q3
          ),
          BottomButton(
            onTap: () {
              httpUtil.matchExercise(form_q1.getResult(), form_q2.getResult(), form_q3.getResult(), 3).then((exercises) => {
                print(exercises),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      recommendedExercises: exercises,
                    ),
                  ),
                )
              });
            },
            buttonTitle: 'SHOW RECOMMENDATIONS',
          ),
        ],
      ),
    );
  }
}
