import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/models/brain.dart';
import 'package:retreatapp/models/exercise.dart';
import 'package:retreatapp/screens/results_page.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import 'input_page.dart';

class ReviewPage extends StatelessWidget {
  final Exercise exercise;
  ReviewPage({this.exercise});
//  List<String> answers;
//  ReviewPage({this.answers});
//
  @override
  Widget build(BuildContext context) {
    Brain brain = Provider.of<Brain>(context, listen: false);
    Map<int, String> answers = brain.answers;

    var title = new RichText(
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        children: <TextSpan>[
          new TextSpan(
              text: 'You\'ve completed the exercise ',
              style: kHeadLineTimeLineTextStyle),
          new TextSpan(
              text: '${exercise.name} ',
              style: kHeadLineTimeLineHighlightTextStyle),
          new TextSpan(text: 'today. Yah!', style: kHeadLineTimeLineTextStyle),
        ],
      ),
    );
    var quote = new RichText(
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        children: <TextSpan>[
//          TextSpan(
//              text: 'We want to tell you that -\n', style: kHeadLineTextStyle),
          TextSpan(
            text:
                '"Self-care is never a selfish act - it is simply good stewardship of the only gift I have, the gift I was put on earth to offer others."\n',
            style: TextStyle(
                fontSize: 24.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: kDarkBlueColor,
                fontFamily: 'OpenSans'),
          ),
        ],
      ),
    );
    var author = new RichText(
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        children: <TextSpan>[
//          TextSpan(
//              text: 'We want to tell you that -\n', style: kHeadLineTextStyle),
          TextSpan(
            text: '(Parker Palmer)',
            style: TextStyle(
                color: kDarkGrayColor, fontFamily: 'OpenSans', fontSize: 22.0),
          ),
        ],
      ),
    );

    var whenYouStartedTimelineText = new RichText(
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        children: <TextSpan>[
          new TextSpan(
              text: 'When you started, you were ', style: kTimeLineTextStyle),
          new TextSpan(
              text: '${brain.currentEmotions.join(', ')} ',
              style: kTimeLineHighlightTextStyle),
          new TextSpan(text: 'about ', style: kTimeLineTextStyle),
          new TextSpan(
              text: '${brain.causesOfEmotion.join(', ')} ',
              style: kTimeLineHighlightTextStyle),
          new TextSpan(text: 'problems.', style: kTimeLineTextStyle),
        ],
      ),
    );
    var thenYouFollowedTheStepsText = new RichText(
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        children: <TextSpan>[
          new TextSpan(
              text:
                  'But in the exercise, you successfully broke the problem into ',
              style: kTimeLineTextStyle),
          new TextSpan(
              text: 'smaller, specific, and manageable steps:',
              style: kTimeLineHighlightTextStyle),
        ],
      ),
    );
    var endRhetorical = new RichText(
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        children: <TextSpan>[
          new TextSpan(
              text: 'Before the exercise, you said you wanted to feel ',
              style: kTimeLineTextStyle),
          new TextSpan(
              text: '${brain.desiredEmotions.join(', ')}. ',
              style: kTimeLineTextStyle),
          new TextSpan(text: 'Are you ', style: kTimeLineTextStyle),
          new TextSpan(
              text: '${brain.desiredEmotions.join(', ')} ',
              style: kTimeLineHighlightTextStyle),
          new TextSpan(text: 'now?', style: kTimeLineTextStyle),
        ],
      ),
    );

    RichText timeLineExerciseStepText({int stepNumber, String instruction}) {
      return new RichText(
        text: new TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          children: <TextSpan>[
            new TextSpan(
                text: 'Step $stepNumber: ', style: kTimeLineHighlightTextStyle),
            new TextSpan(text: '$instruction', style: kTimeLineTextStyle),
          ],
        ),
      );
    }

    RichText timeLineExerciseAnswerText({String response}) {
      return new RichText(
        text: new TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          children: <TextSpan>[
            new TextSpan(
                text: 'You wrote: ', style: kTimeLineHighlightTextStyle),
            new TextSpan(text: '$response', style: kTimeLineTextStyle),
          ],
        ),
      );
    }

    List<TimelineModel> generateTimeLine() {
      List<TimelineModel> events = [];
      events.add(
        TimelineModel(
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                whenYouStartedTimelineText,
//                new FadeInImage.memoryNetwork(
//                  placeholder: kTransparentImage,
//                  image: 'images/ending-2.jpeg',
//                  fit: BoxFit.fitWidth,
//                  imageScale: 2.5,
//                ),
              ],
            ),
          ),
          position: TimelineItemPosition.left,
          iconBackground: kDarkBlueColor,
        ),
      );
//      events.add(
//        TimelineModel(
//          Padding(
//            padding: const EdgeInsets.all(28.0),
//            child: Column(
//              children: [
////                whenYouStartedTimelineText,
//                new FadeInImage.memoryNetwork(
//                  placeholder: kTransparentImage,
//                  image: 'images/ending-2.jpeg',
//                  fit: BoxFit.fitWidth,
//                  imageScale: 2.5,
//                ),
//              ],
//            ),
//          ),
//          position: TimelineItemPosition.right,
//          iconBackground: kDarkBlueColor,
//        ),
//      );
      events.add(
        TimelineModel(
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                thenYouFollowedTheStepsText,
              ],
            ),
          ),
          position: TimelineItemPosition.right,
          iconBackground: kDarkBlueColor,
        ),
      );

      for (int i = 1; i <= answers.length; i++) {
        if (i == 1) {
          // first step has image before question prompt
          events.add(
            TimelineModel(
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
//                    new FadeInImage.memoryNetwork(
//                      placeholder: kTransparentImage,
//                      image: 'images/ending-2.jpeg',
//                      fit: BoxFit.fitWidth,
//                      imageScale: 2.5,
//                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: exercise.instructions[i] == null
                          ? Text('')
                          : timeLineExerciseStepText(
                              stepNumber: i,
                              instruction: exercise.instructions[i].content),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: answers[i] == null
                          ? Text('')
                          : timeLineExerciseAnswerText(response: answers[i]),
                    ),
                  ],
                ),
              ),
              position: i % 2 == 0
                  ? TimelineItemPosition.right
                  : TimelineItemPosition.left,
              iconBackground: kDarkBlueColor,
            ),
          );
        } else if (i == answers.length) {
          // last step has image after question prompt and user input
          events.add(
            TimelineModel(
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
//                    new FadeInImage.memoryNetwork(
//                      placeholder: kTransparentImage,
//                      image: 'images/ending-3.jpeg',
//                      fit: BoxFit.fitWidth,
//                      imageScale: 2.5,
//                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: exercise.instructions[i] == null
                          ? Text('')
                          : timeLineExerciseStepText(
                              stepNumber: i,
                              instruction: exercise.instructions[i].content),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: answers[i] == null
                          ? Text('')
                          : timeLineExerciseAnswerText(response: answers[i]),
                    ),
                  ],
                ),
              ),
              position: i % 2 == 0
                  ? TimelineItemPosition.right
                  : TimelineItemPosition.left,
              iconBackground: kDarkBlueColor,
            ),
          );
        } else {
          // in between steps don't have image
          events.add(
            TimelineModel(
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: exercise.instructions[i] == null
                          ? Text('')
                          : timeLineExerciseStepText(
                              stepNumber: i,
                              instruction: exercise.instructions[i].content),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: answers[i] == null
                          ? Text('')
                          : timeLineExerciseAnswerText(response: answers[i]),
                    ),
                  ],
                ),
              ),
              position: i % 2 == 0
                  ? TimelineItemPosition.right
                  : TimelineItemPosition.left,
              iconBackground: kDarkBlueColor,
            ),
          );
        }
      }

      return events;
    }

    return Material(
      child: FractionallySizedBox(
        widthFactor: kWidthFactor,
        child: ListView(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      formatDate(new DateTime.now(), [MM, ' ', d, ', ', yyyy]),
                      style: kTitleTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90.0, 60.0, 90.0, 0.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: title,
                        ),
                        Expanded(
                          flex: 1,
                          child: new FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: 'images/ending-2.jpeg',
                            fit: BoxFit.contain,
                            imageScale: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90.0, 30.0, 90.0, 30.0),
                    child: SizedBox(
                      height: (MediaQuery.of(context).size.height * 0.4) *
                          max(exercise.instructions.length - 2, 1),
                      child: Timeline(
                        children: generateTimeLine(),
                        position: TimelinePosition.Center,
                        lineColor: kDarkBlueColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90.0, 0.0, 90.0, 60.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: new FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: 'images/ending-3.jpeg',
                            fit: BoxFit.contain,
                            imageScale: 14,
                          ),
                        ),
                        Expanded(flex: 4, child: endRhetorical),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90.0, 30.0, 90.0, 0.0),
                    child: quote,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90.0, 0.0, 90.0, 30.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: author,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: kWidthFactor,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RaisedButton(
                        child: Text(
                          'Exit the Exercise',
                          style: kBody1TextStyle,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        color: Colors.white,
                        onPressed: () {
                          Provider.of<Brain>(context, listen: false)
                                  .getRecommendExercises().then( (recommendedExercises) => {
                                  recommendedExercises.forEach((element) {
                                  print(element.name);
                                  }),
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InputPage(),
                                  ),
                              ),
                          });
                        },
                      ),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        child: Text(
                          'Share Anonymously(coming soon)',
                          style: kBody2TextStyle,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        color: kDarkBlueColor,
                        onPressed: () {
                          // share anonymously
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

//  final List<TimelineModel> items = [
//    TimelineModel(
//      Text(widget.answers.toString()),
//      position: TimelineItemPosition.random,
//    ),
//    TimelineModel(Placeholder(),
//        position: TimelineItemPosition.random,
//        iconBackground: Colors.redAccent,
//        icon: Icon(Icons.blur_circular)),
//  ];
}

//class ReviewPage extends StatelessWidget {
//  Exercise exercise;
//  ReviewPage({this.exercise});
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: [
//        Text(''),
//        Timeline(
//          children: items,
//          position: TimelinePosition.Center,
//          lineColor: kDarkBlueColor,
//        ),
//      ],
//    );
//  }
//
//  List<TimelineModel> items = [
//    TimelineModel(
//      Placeholder(),
//      position: TimelineItemPosition.random,
//    ),
//    TimelineModel(Placeholder(),
//        position: TimelineItemPosition.random,
//        iconBackground: Colors.redAccent,
//        icon: Icon(Icons.blur_circular)),
//  ];
//}
