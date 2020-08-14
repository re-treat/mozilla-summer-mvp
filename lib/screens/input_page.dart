import 'package:flutter/material.dart';
import 'package:retreatapp/components/card_box_decoration.dart';
import 'package:retreatapp/components/cause_of_emotion_filter.dart';
import 'package:retreatapp/components/desired_emotion_filter.dart';
import 'package:retreatapp/components/emotion_filter.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/screens/results_page.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color answerTextColor = kInactiveCardColour;

  final questions = [
    'What emotion(s) are you feeling right now?',
    'What might have caused you to feel these emotions?',
    'What do you wish to achieve by this exercise?'
  ];

  var title = new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: kTitleTextStyle,
      children: <TextSpan>[
        new TextSpan(text: 'Tell me ', style: kTitleTextStyle),
        new TextSpan(text: 'more ', style: kTitleHighlightTextStyle),
        new TextSpan(text: 'about your feelings ...', style: kTitleTextStyle),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            FractionallySizedBox(
              widthFactor: kWidthFactor,
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 60.0, 60.0, 30.0),
                child: title,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            FractionallySizedBox(
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
                            questions[0],
                            style: kHeadLineTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: EmotionFilter(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            FractionallySizedBox(
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
                            questions[1],
                            style: kHeadLineTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: CauseOfEmotionFilter(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            FractionallySizedBox(
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
                            questions[2],
                            style: kHeadLineTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: DesiredEmotionFilter(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            FractionallySizedBox(
              widthFactor: kWidthFactor,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: kLightGrayColor),
                      ),
                      color: kDarkBlueColor,
                      textColor: kWhiteColor,
                      child: InkWell(
                        child: new Text(
                          "Exercise Recommendations",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultsPage(
                              recommendedExercises: [""],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
  );
}

  BoxDecoration textBoxDecoration() {
    return BoxDecoration(
      color: kLightGrayColor,
      border: Border.all(),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );
  }
}

ButtonBar questionOneAnswers() {
  return ButtonBar(
    children: <Widget>[
      FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: kLightGrayColor),
        ),
        color: kLightGrayColor,
        textColor: kDarkGrayColor,
        child: const Text('BUY TICKETS'),
        onPressed: () {/* ... */},
      ),
    ],
  );
}

List<FlatButton> clickableAnswerLabels(List answers) {
  List<FlatButton> list = new List<FlatButton>();
  for (var i = 0; i < answers.length; i++) {
    list.add(new FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: kLightGrayColor),
      ),
      color: kLightGrayColor,
      textColor: kDarkGrayColor,
      child: Text(answers[i]),
      onPressed: () {/* ... */},
    ));
  }
  return list;
}
