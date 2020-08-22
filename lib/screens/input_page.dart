import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:retreatapp/components/card_box_decoration.dart';
import 'package:retreatapp/components/cause_of_emotion_filter.dart';
import 'package:retreatapp/components/desired_emotion_filter.dart';
import 'package:retreatapp/components/emotion_filter.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/screens/results_page.dart';

import '../models/brain.dart';
import '../models/exercise.dart';

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
//        new TextSpan(text: '               '),
        new TextSpan(text: 'Tell me ', style: kTitleTextStyle),
        new TextSpan(text: 'more ', style: kTitleHighlightTextStyle),
        new TextSpan(text: 'about your feelings ...', style: kTitleTextStyle),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: title,
//        shadowColor: Colors.white,
//        toolbarHeight: 120.0,
//        centerTitle: false,
//      ),
      body: Center(child: Consumer<Brain>(
        builder: (context, brain, child) {
          return ListView(
            children: [
              // Header
              FractionallySizedBox(
                widthFactor: kWidthFactor,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 60.0, 15.0),
                  child: title,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              // Question 1
              FractionallySizedBox(
                widthFactor: kWidthFactor,
                child: DecoratedBox(
                  decoration: cardBoxDecoration(),
                  child: Padding(
                    padding: inputCardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              questions[0],
                              style: kHeadLineTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: new EmotionFilter(brain: brain),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // Question 2
              FractionallySizedBox(
                widthFactor: kWidthFactor,
                child: DecoratedBox(
                  decoration: cardBoxDecoration(),
                  child: Padding(
                    padding: inputCardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              questions[1],
                              style: kHeadLineTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: new CauseOfEmotionFilter(brain: brain),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // Question 3
              FractionallySizedBox(
                widthFactor: kWidthFactor,
                child: DecoratedBox(
                  decoration: cardBoxDecoration(),
                  child: Padding(
                    padding: inputCardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              questions[2],
                              style: kHeadLineTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: new DesiredEmotionFilter(brain: brain),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // bottom buttons
              FractionallySizedBox(
                widthFactor: kWidthFactor,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      FloatingActionButton.extended(
                        label: Text('Next'),
                        icon: Icon(Icons.arrow_forward_ios),
                        backgroundColor: kDarkBlueColor,
                        onPressed: () {
                          final Set<Exercise> recommendedExercises =
                              Provider.of<Brain>(context, listen: false)
                                  .getRecommendExercises();

                          if (recommendedExercises.length > 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultsPage(),
                              ),
                            );
                          } else {
                            print('no exercises selected');
                            showToast(
                              "Please make a selection to continue.",
                              position: ToastPosition.bottom,
                              backgroundColor: kDarkBlueColor,
                              radius: 13.0,
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  backgroundColor: kDarkBlueColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                  fontFamily: 'OpenSans'),
                              animationBuilder: Miui10AnimBuilder(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      )),

//      floatingActionButton: FloatingActionButton.extended(
//        label: Text('Next'),
//        icon: Icon(Icons.arrow_forward_ios),
//        backgroundColor: kDarkBlueColor,
//        onPressed: () {
//          final Set<Exercise> recommendedExercises =
//              Provider.of<Brain>(context, listen: false)
//                  .getRecommendExercises();
//          recommendedExercises.forEach((element) {
//            print(element.name);
//          });
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => ResultsPage(
//                recommendedExercises: <Exercise>{},
//              ),
//            ),
//          );
//        },
//      ),
    );
  }
}
