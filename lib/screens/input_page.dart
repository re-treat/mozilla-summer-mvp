import 'dart:convert';
import 'dart:core';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:retreatapp/components/bottom_button.dart';
import 'package:retreatapp/components/reusable_question_card.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/screens/results_page.dart';

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

  var myFeelingsChoices;

  _InputPageState() {
    getLabels("q1").then((value) => myFeelingsChoices = value);
  }

  Future<List<String>> getLabels(String question) async {
    final http.Response response = await http.post('localhost:8080/getLabels',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'question': question,
      }),
    );
    print(response.body);
    return json.decode(response.body);
  }



  /*[
    {
      "display": "Angry",
      "value": "Angry",
    },
    {
      "display": "Sad",
      "value": "Sad",
    },
    {
      "display": "Anxious",
      "value": "Anxious",
    },
    {
      "display": "Hurt",
      "value": "Hurt",
    },
    {
      "display": "Embarrassed",
      "value": "Embarrassed",
    },
  ]; */

  final causeOfFeelingChoices = [
    {
      "display": "Work",
      "value": "Work",
    },
    {
      "display": "School",
      "value": "School",
    },
    {
      "display": "Finance",
      "value": "Finance",
    },
    {
      "display": "Relationship",
      "value": "Relationship",
    },
  ];

  final desiredFeelingChoices = [
    {
      "display": "Thankful",
      "value": "Thankful",
    },
    {
      "display": "Relaxed",
      "value": "Relaxed",
    },
    {
      "display": "Relieved",
      "value": "Relieved",
    },
    {
      "display": "Confident",
      "value": "Confident",
    },
    {
      "display": "Motivated",
      "value": "Motivated",
    },
  ];

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
