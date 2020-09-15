import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:retreatapp/components/card_box_decoration.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/models/brain.dart';
import 'package:retreatapp/models/exercise.dart';
import 'package:retreatapp/screens/review_page.dart';

//https://stackoverflow.com/questions/59130685/flutter-populating-steps-content-based-on-previous-selection-on-stepper

class ExercisePage extends StatefulWidget {
  final Exercise exercise;
  const ExercisePage({this.exercise});

  @override
  _ExercisePageState createState() => new _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int _currentStep = 0;
  var answers = new Map();
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Last text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    final List<Instruction> instructions = widget.exercise.instructions;
    final totalSteps = instructions.length;
    Brain brain = Provider.of<Brain>(context, listen: false);

    List<Step> generateSteps() {
      List<Step> steps = [];
      for (int i = 0; i < totalSteps; i++) {
        steps.add(Step(
          title: const Text(''),
          isActive: _currentStep >= i,
          state:
              _currentStep >= i + 1 ? StepState.complete : StepState.disabled,
          content: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 18.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _currentStep >= totalSteps - 1
                      ? titles[titles.length - 1]
                      : titles[i],
                ),
              ),
              DecoratedBox(
                decoration: cardBoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        // step number avatar
                        leading: CircleAvatar(
                          radius: 60.0,
                          foregroundColor: kDarkBlueColor,
                          child: Text(
                            (i + 1).toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w900),
                          ),
                          backgroundColor: kDarkBlueColor,
                        ),
                        title: Text(
                          instructions[i].content,
                          style: kHeadLineTimeLineTextStyle,
                        ),
                      ),
                      // user input/response only if 'entry'
                      instructions[i].type == 'entry'
                          ? Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50.0, 20.0, 0, 0),
                              child: new TextField(
                                controller: myController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                autofocus: true,
                                onChanged: (answer) {
                                  answers[i] = answer;
                                },
                                style: kInputTextStyle,
                                decoration: InputDecoration(
                                    labelText: 'Your thoughts here...',
                                    labelStyle: kLabelTextStyle),
                              ),
                            )
                          : Text(''),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
      }
      return steps;
    }

    void stepContinue() {
      if (_currentStep < totalSteps - 1) {
        setState(() {
          if (myController.text.length == 0 &&
              widget.exercise.instructions[_currentStep].type == 'entry') {
            showToast(
              "Please add your thoughts to continue.",
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
          } else {
            _currentStep += 1;
            myController.clear();
          }
        });
      } else {
        if (myController.text.length == 0 &&
            widget.exercise.instructions[_currentStep].type == 'entry') {
          showToast(
            "Please complete exercise to continue.",
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
        } else {
          Exercise exercise = widget.exercise;
          brain.addAnswers(Map.from(answers));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewPage(
                exercise: exercise,
              ),
            ),
          );
        }
      }
    }

    return FractionallySizedBox(
      widthFactor: kWidthFactor,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(18.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: kDarkGrayColor,
              ),
            ),
          ),
          title: Text(
            'Exercise Instructions: ${widget.exercise.name}',
            style: kHeadLineTextStyle,
          ),
        ),
        body: Theme(
          data: ThemeData(primaryColor: kDarkOrangeColor),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              onStepTapped: (int step) => setState(() => _currentStep = step),
              onStepContinue: stepContinue,
              onStepCancel: _currentStep > 0
                  ? () => setState(() => _currentStep -= 1)
                  : null,
              controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) =>
                  // buttons
                  Container(
                height: 70,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _currentStep == 0
                        ? Text("")
                        : RaisedButton(
                            onPressed: onStepCancel,
                            textColor: Colors.white,
                            color: _currentStep == 0
                                ? Colors.grey
                                : kDarkOrangeColor,
                            textTheme: ButtonTextTheme.normal,
                            child: Row(children: <Widget>[
                              const Icon(Icons.chevron_left),
                              Text("PREV")
                            ]),
                          ),
                    RaisedButton(
                      onPressed: onStepContinue,
                      textColor: Colors.white,
                      color: kDarkOrangeColor,
                      textTheme: ButtonTextTheme.normal,
                      child: Row(children: <Widget>[
                        _currentStep >= totalSteps - 1
                            ? Icon(Icons.done)
                            : Icon(Icons.chevron_right),
                        _currentStep >= totalSteps - 1
                            ? Text("FINALIZE")
                            : Text("NEXT")
                      ]),
                    ),
                  ],
                ),
              ),
              steps: generateSteps(),
            );
          }),
        ),
      ),
    );
  }
}

//  static int currentStep = 0;
//  static bool complete = false;

List<RichText> titles = [
  new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      children: <TextSpan>[
        new TextSpan(text: 'Let\'s get ', style: kTitleTextStyle),
        new TextSpan(text: 'started', style: kTitleHighlightTextStyle),
        new TextSpan(text: '...', style: kTitleTextStyle),
      ],
    ),
  ),
  new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: kTitleTextStyle,
      children: <TextSpan>[
        new TextSpan(text: 'You\'re doing ', style: kTitleTextStyle),
        new TextSpan(text: 'great', style: kTitleHighlightTextStyle),
        new TextSpan(text: '!', style: kTitleTextStyle),
      ],
    ),
  ),
  new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: kTitleTextStyle,
      children: <TextSpan>[
        new TextSpan(text: 'You\'re ', style: kTitleTextStyle),
        new TextSpan(text: 'almost ', style: kTitleHighlightTextStyle),
        new TextSpan(text: 'there!', style: kTitleTextStyle),
      ],
    ),
  ),
  new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: kTitleTextStyle,
      children: <TextSpan>[
        new TextSpan(text: 'Keep ', style: kTitleTextStyle),
        new TextSpan(text: 'going ', style: kTitleHighlightTextStyle),
        new TextSpan(text: '!', style: kTitleTextStyle),
      ],
    ),
  ),
  new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: kTitleTextStyle,
      children: <TextSpan>[
        new TextSpan(text: 'You\'re doing ', style: kTitleTextStyle),
        new TextSpan(text: 'great ', style: kTitleHighlightTextStyle),
        new TextSpan(text: '!', style: kTitleTextStyle),
      ],
    ),
  ),
  new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: kTitleTextStyle,
      children: <TextSpan>[
        new TextSpan(text: 'Just one ', style: kTitleTextStyle),
        new TextSpan(text: 'final ', style: kTitleHighlightTextStyle),
        new TextSpan(text: 'step!', style: kTitleTextStyle),
      ],
    ),
  ),
//  new RichText(
//    text: new TextSpan(
//      // Note: Styles for TextSpans must be explicitly defined.
//      // Child text spans will inherit styles from parent
//      style: kTitleTextStyle,
//      children: <TextSpan>[
//        new TextSpan(text: 'Yay ', style: kTitleHighlightTextStyle),
//        new TextSpan(text: 'we\'re finished!', style: kTitleTextStyle),
//      ],
//    ),
//  ),
];
int i = 0;
