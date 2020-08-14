import 'package:flutter/material.dart';
import 'package:retreatapp/components/card_box_decoration.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/exercise.dart';

//https://stackoverflow.com/questions/59130685/flutter-populating-steps-content-based-on-previous-selection-on-stepper

class ExercisePage extends StatefulWidget {
  final List<Instruction> instructions;

  const ExercisePage({this.instructions});

  @override
  _ExercisePageState createState() => new _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    List<Instruction> instructions = widget.instructions;
    final totalSteps = instructions.length;

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
                padding: const EdgeInsets.symmetric(vertical: 38.0),
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
                  padding: const EdgeInsets.all(72.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          radius: 50.0,
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
                          instructions[i].detail,
                          style: kHeadLineTextStyle,
                        ),
                      ),
                      instructions[i].type == 'text entry'
                          ? Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50.0, 50.0, 0, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                autofocus: true,
                                style: kHeadLineTextStyle,
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

    return FractionallySizedBox(
      widthFactor: kWidthFactor,
      child: Scaffold(
        body: Theme(
          data: ThemeData(primaryColor: kDarkOrangeColor),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              onStepTapped: (int step) => setState(() => _currentStep = step),
              onStepContinue: _currentStep < totalSteps - 1
                  ? () => setState(() => _currentStep += 1)
                  : null,
              onStepCancel: _currentStep > 0
                  ? () => setState(() => _currentStep -= 1)
                  : null,
              controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) =>
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
                        _currentStep >= totalSteps ? Text("DONE") : Text("NEXT")
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
      style: kTitleTextStyle,
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
        new TextSpan(text: 'Yay ', style: kTitleHighlightTextStyle),
        new TextSpan(text: 'we\'re finished!', style: kTitleTextStyle),
      ],
    ),
  ),
];
int i = 0;

//<Step>[
//                Step(
//                  title: const Text(''),
//                  isActive: _currentStep >= 0,
//                  state: _currentStep >= 1
//                      ? StepState.complete
//                      : StepState.disabled,
//                  content: Column(
//                    children: [
//                      Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 38.0),
//                        child: Align(
//                          alignment: Alignment.centerLeft,
//                          child: titles[i],
//                        ),
//                      ),
//                      DecoratedBox(
//                        decoration: cardBoxDecoration(),
//                        child: Padding(
//                          padding: const EdgeInsets.all(72.0),
//                          child: Column(
//                            children: <Widget>[
//                              ListTile(
//                                leading: CircleAvatar(
//                                  radius: 50.0,
//                                  foregroundColor: kDarkBlueColor,
//                                  child: Text(
//                                    (i + 1).toString(),
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontSize: 48,
//                                        fontWeight: FontWeight.w900),
//                                  ),
//                                  backgroundColor: kDarkBlueColor,
//                                ),
//                                title: Text(
//                                  exercises[i].instructions[i].detail,
//                                  style: kHeadLineTextStyle,
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Step(
//                  title: const Text(''),
//                  isActive: _currentStep >= 1,
//                  state: _currentStep >= 2
//                      ? StepState.complete
//                      : StepState.disabled,
//                  content: Column(
//                    children: [
//                      Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 38.0),
//                        child: Align(
//                          alignment: Alignment.centerLeft,
//                          child: titles[i + 1],
//                        ),
//                      ),
//                      DecoratedBox(
//                        decoration: cardBoxDecoration(),
//                        child: Padding(
//                          padding: const EdgeInsets.all(72.0),
//                          child: Column(
//                            children: <Widget>[
//                              ListTile(
//                                leading: CircleAvatar(
//                                  radius: 50.0,
//                                  foregroundColor: kDarkBlueColor,
//                                  child: Text(
//                                    (i + 2).toString(),
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontSize: 48,
//                                        fontWeight: FontWeight.w900),
//                                  ),
//                                  backgroundColor: kDarkBlueColor,
//                                ),
//                                title: Text(
//                                  exercises[i + 1].instructions[i + 1].detail,
//                                  style: kHeadLineTextStyle,
//                                ),
//                              ),
//                              Padding(
//                                padding:
//                                    const EdgeInsets.fromLTRB(50.0, 50.0, 0, 0),
//                                child: TextFormField(
//                                  keyboardType: TextInputType.multiline,
//                                  maxLines: null,
//                                  autofocus: true,
//                                  style: kHeadLineTextStyle,
//                                  decoration: InputDecoration(
//                                      labelText: 'Your thoughts here...',
//                                      labelStyle: kLabelTextStyle),
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Step(
//                  title: const Text(''),
//                  isActive: _currentStep >= 2,
//                  state: _currentStep >= 3
//                      ? StepState.complete
//                      : StepState.disabled,
//                  content: Column(
//                    children: [
//                      Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 38.0),
//                        child: Align(
//                          alignment: Alignment.centerLeft,
//                          child: titles[i + 2],
//                        ),
//                      ),
//                      DecoratedBox(
//                        decoration: cardBoxDecoration(),
//                        child: Padding(
//                          padding: const EdgeInsets.all(72.0),
//                          child: Column(
//                            children: <Widget>[
//                              ListTile(
//                                leading: CircleAvatar(
//                                  radius: 50.0,
//                                  foregroundColor: kDarkBlueColor,
//                                  child: Text(
//                                    (i + 3).toString(),
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontSize: 48,
//                                        fontWeight: FontWeight.w900),
//                                  ),
//                                  backgroundColor: kDarkBlueColor,
//                                ),
//                                title: Text(
//                                  exercises[i + 2].instructions[i + 2].detail,
//                                  style: kHeadLineTextStyle,
//                                ),
//                              ),
//                              Padding(
//                                padding:
//                                    const EdgeInsets.fromLTRB(50.0, 50.0, 0, 0),
//                                child: TextFormField(
//                                  keyboardType: TextInputType.multiline,
//                                  maxLines: null,
//                                  autofocus: true,
//                                  style: kHeadLineTextStyle,
//                                  decoration: InputDecoration(
//                                      labelText: 'Your thoughts here...',
//                                      labelStyle: kLabelTextStyle),
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Step(
//                  title: const Text(''),
//                  isActive: _currentStep >= 3,
//                  state: _currentStep >= 4
//                      ? StepState.complete
//                      : StepState.disabled,
//                  content: Column(
//                    children: [
//                      Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 38.0),
//                        child: Align(
//                          alignment: Alignment.centerLeft,
//                          child: titles[i + 3],
//                        ),
//                      ),
//                      DecoratedBox(
//                        decoration: cardBoxDecoration(),
//                        child: Padding(
//                          padding: const EdgeInsets.all(72.0),
//                          child: Column(
//                            children: <Widget>[
//                              ListTile(
//                                leading: CircleAvatar(
//                                  radius: 50.0,
//                                  foregroundColor: kDarkBlueColor,
//                                  child: Text(
//                                    (i + 4).toString(),
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontSize: 48,
//                                        fontWeight: FontWeight.w900),
//                                  ),
//                                  backgroundColor: kDarkBlueColor,
//                                ),
//                                title: Text(
//                                  exercises[i + 3].instructions[i + 3].detail,
//                                  style: kHeadLineTextStyle,
//                                ),
//                              ),
//                              Padding(
//                                padding:
//                                    const EdgeInsets.fromLTRB(50.0, 50.0, 0, 0),
//                                child: TextFormField(
//                                  keyboardType: TextInputType.multiline,
//                                  maxLines: null,
//                                  autofocus: true,
//                                  style: kHeadLineTextStyle,
//                                  decoration: InputDecoration(
//                                      labelText: 'Your thoughts here...',
//                                      labelStyle: kLabelTextStyle),
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//  List<Step> steps = [
//    Step(
//      title: const Text(''),
//      isActive: _currentStep >= 0,
//      state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
//      content: Column(
//        children: [
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 38.0),
//            child: Align(
//              alignment: Alignment.centerLeft,
//              child: titles[i],
//            ),
//          ),
//          DecoratedBox(
//            decoration: cardBoxDecoration(),
//            child: Padding(
//              padding: const EdgeInsets.all(72.0),
//              child: Column(
//                children: <Widget>[
//                  ListTile(
//                    leading: CircleAvatar(
//                      radius: 50.0,
//                      foregroundColor: kDarkBlueColor,
//                      child: Text(
//                        (i + 1).toString(),
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 48,
//                            fontWeight: FontWeight.w900),
//                      ),
//                      backgroundColor: kDarkBlueColor,
//                    ),
//                    title: Text(
//                      exercises[i].instructions[i].detail,
//                      style: kHeadLineTextStyle,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    ),
//    Step(
//      title: const Text(''),
//      isActive: _currentStep >= 1,
//      state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
//      content: Column(
//        children: [
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 38.0),
//            child: Align(
//              alignment: Alignment.centerLeft,
//              child: titles[i + 1],
//            ),
//          ),
//          DecoratedBox(
//            decoration: cardBoxDecoration(),
//            child: Padding(
//              padding: const EdgeInsets.all(72.0),
//              child: Column(
//                children: <Widget>[
//                  ListTile(
//                    leading: CircleAvatar(
//                      radius: 50.0,
//                      foregroundColor: kDarkBlueColor,
//                      child: Text(
//                        (i + 2).toString(),
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 48,
//                            fontWeight: FontWeight.w900),
//                      ),
//                      backgroundColor: kDarkBlueColor,
//                    ),
//                    title: Text(
//                      exercises[i + 1].instructions[i + 1].detail,
//                      style: kHeadLineTextStyle,
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(50.0, 50.0, 0, 0),
//                    child: TextFormField(
//                      keyboardType: TextInputType.multiline,
//                      maxLines: null,
//                      autofocus: true,
//                      style: kHeadLineTextStyle,
//                      decoration: InputDecoration(
//                          labelText: 'Your thoughts here...',
//                          labelStyle: kLabelTextStyle),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    ),
//    Step(
//      title: const Text(''),
//      isActive: _currentStep >= 2,
//      state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
//      content: Column(
//        children: [
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 38.0),
//            child: Align(
//              alignment: Alignment.centerLeft,
//              child: titles[i + 2],
//            ),
//          ),
//          DecoratedBox(
//            decoration: cardBoxDecoration(),
//            child: Padding(
//              padding: const EdgeInsets.all(72.0),
//              child: Column(
//                children: <Widget>[
//                  ListTile(
//                    leading: CircleAvatar(
//                      radius: 50.0,
//                      foregroundColor: kDarkBlueColor,
//                      child: Text(
//                        (i + 3).toString(),
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 48,
//                            fontWeight: FontWeight.w900),
//                      ),
//                      backgroundColor: kDarkBlueColor,
//                    ),
//                    title: Text(
//                      exercises[i + 2].instructions[i + 2].detail,
//                      style: kHeadLineTextStyle,
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(50.0, 50.0, 0, 0),
//                    child: TextFormField(
//                      keyboardType: TextInputType.multiline,
//                      maxLines: null,
//                      autofocus: true,
//                      style: kHeadLineTextStyle,
//                      decoration: InputDecoration(
//                          labelText: 'Your thoughts here...',
//                          labelStyle: kLabelTextStyle),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    ),
//    Step(
//      title: const Text(''),
//      isActive: _currentStep >= 3,
//      state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
//      content: Column(
//        children: [
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 38.0),
//            child: Align(
//              alignment: Alignment.centerLeft,
//              child: titles[i + 3],
//            ),
//          ),
//          DecoratedBox(
//            decoration: cardBoxDecoration(),
//            child: Padding(
//              padding: const EdgeInsets.all(72.0),
//              child: Column(
//                children: <Widget>[
//                  ListTile(
//                    leading: CircleAvatar(
//                      radius: 50.0,
//                      foregroundColor: kDarkBlueColor,
//                      child: Text(
//                        (i + 4).toString(),
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 48,
//                            fontWeight: FontWeight.w900),
//                      ),
//                      backgroundColor: kDarkBlueColor,
//                    ),
//                    title: Text(
//                      exercises[i + 3].instructions[i + 3].detail,
//                      style: kHeadLineTextStyle,
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(50.0, 50.0, 0, 0),
//                    child: TextFormField(
//                      keyboardType: TextInputType.multiline,
//                      maxLines: null,
//                      autofocus: true,
//                      style: kHeadLineTextStyle,
//                      decoration: InputDecoration(
//                          labelText: 'Your thoughts here...',
//                          labelStyle: kLabelTextStyle),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    ),
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: AppBar(
//        title: Text('Create an account'),
//      ),
//      body: Center(
//        child: FractionallySizedBox(
//          widthFactor: kWidthFactor,
//          child: Column(
//            children: <Widget>[
//              complete
//                  ? Expanded(
//                      child: Center(
//                        child: AlertDialog(
//                          title: new Text("Profile Created"),
//                          content: new Text(
//                            "Tada!",
//                          ),
//                          actions: <Widget>[
//                            new FlatButton(
//                              child: new Text("Close"),
//                              onPressed: () {
//                                setState(() => complete = false);
//                              },
//                            ),
//                          ],
//                        ),
//                      ),
//                    )
//                  : Expanded(
//                      child: Theme(
//                          data: ThemeData.light(),
//                          child: StatefulBuilder(
//                            builder:
//                                (BuildContext context, StateSetter setter) {
//                              return Stepper(
//                                type: stepperType,
//                                currentStep: currentStep,
//                                onStepContinue: next,
//                                onStepTapped: (step) => goTo(step),
//                                onStepCancel: cancel,
//                                steps: <Step>[
//                                  Step(
//                                    title: const Text(''),
//                                    isActive: currentStep >= 0,
//                                    state: currentStep >= 0
//                                        ? StepState.complete
//                                        : StepState.disabled,
//                                    content: Column(
//                                      children: [
//                                        Padding(
//                                          padding: const EdgeInsets.symmetric(
//                                              vertical: 38.0),
//                                          child: Align(
//                                            alignment: Alignment.centerLeft,
//                                            child: titles[i],
//                                          ),
//                                        ),
//                                        DecoratedBox(
//                                          decoration: cardBoxDecoration(),
//                                          child: Padding(
//                                            padding: const EdgeInsets.all(72.0),
//                                            child: Column(
//                                              children: <Widget>[
//                                                ListTile(
//                                                  leading: CircleAvatar(
//                                                    radius: 50.0,
//                                                    foregroundColor:
//                                                        kDarkBlueColor,
//                                                    child: Text(
//                                                      (i + 1).toString(),
//                                                      style: TextStyle(
//                                                          color: Colors.white,
//                                                          fontSize: 48,
//                                                          fontWeight:
//                                                              FontWeight.w900),
//                                                    ),
//                                                    backgroundColor:
//                                                        kDarkBlueColor,
//                                                  ),
//                                                  title: Text(
//                                                    exercises[i]
//                                                        .instructions[i]
//                                                        .detail,
//                                                    style: kHeadLineTextStyle,
//                                                  ),
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  Step(
//                                    title: const Text(''),
//                                    isActive: currentStep >= 1,
//                                    state: currentStep >= 2
//                                        ? StepState.complete
//                                        : StepState.disabled,
//                                    content: Column(
//                                      children: [
//                                        Padding(
//                                          padding: const EdgeInsets.symmetric(
//                                              vertical: 38.0),
//                                          child: Align(
//                                            alignment: Alignment.centerLeft,
//                                            child: titles[i + 1],
//                                          ),
//                                        ),
//                                        DecoratedBox(
//                                          decoration: cardBoxDecoration(),
//                                          child: Padding(
//                                            padding: const EdgeInsets.all(72.0),
//                                            child: Column(
//                                              children: <Widget>[
//                                                ListTile(
//                                                  leading: CircleAvatar(
//                                                    radius: 50.0,
//                                                    foregroundColor:
//                                                        kDarkBlueColor,
//                                                    child: Text(
//                                                      (i + 2).toString(),
//                                                      style: TextStyle(
//                                                          color: Colors.white,
//                                                          fontSize: 48,
//                                                          fontWeight:
//                                                              FontWeight.w900),
//                                                    ),
//                                                    backgroundColor:
//                                                        kDarkBlueColor,
//                                                  ),
//                                                  title: Text(
//                                                    exercises[i + 1]
//                                                        .instructions[i + 1]
//                                                        .detail,
//                                                    style: kHeadLineTextStyle,
//                                                  ),
//                                                ),
//                                                Padding(
//                                                  padding:
//                                                      const EdgeInsets.fromLTRB(
//                                                          50.0, 50.0, 0, 0),
//                                                  child: TextFormField(
//                                                    keyboardType:
//                                                        TextInputType.multiline,
//                                                    maxLines: null,
//                                                    autofocus: true,
//                                                    style: kHeadLineTextStyle,
//                                                    decoration: InputDecoration(
//                                                        labelText:
//                                                            'Your thoughts here...',
//                                                        labelStyle:
//                                                            kLabelTextStyle),
//                                                  ),
//                                                )
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  Step(
//                                    title: const Text(''),
//                                    isActive: activeStates[2],
//                                    state: stepStates[2],
//                                    content: Column(
//                                      children: [
//                                        Padding(
//                                          padding: const EdgeInsets.symmetric(
//                                              vertical: 38.0),
//                                          child: Align(
//                                            alignment: Alignment.centerLeft,
//                                            child: titles[i + 2],
//                                          ),
//                                        ),
//                                        DecoratedBox(
//                                          decoration: cardBoxDecoration(),
//                                          child: Padding(
//                                            padding: const EdgeInsets.all(72.0),
//                                            child: Column(
//                                              children: <Widget>[
//                                                ListTile(
//                                                  leading: CircleAvatar(
//                                                    radius: 50.0,
//                                                    foregroundColor:
//                                                        kDarkBlueColor,
//                                                    child: Text(
//                                                      (i + 3).toString(),
//                                                      style: TextStyle(
//                                                          color: Colors.white,
//                                                          fontSize: 48,
//                                                          fontWeight:
//                                                              FontWeight.w900),
//                                                    ),
//                                                    backgroundColor:
//                                                        kDarkBlueColor,
//                                                  ),
//                                                  title: Text(
//                                                    exercises[i + 2]
//                                                        .instructions[i + 2]
//                                                        .detail,
//                                                    style: kHeadLineTextStyle,
//                                                  ),
//                                                ),
//                                                Padding(
//                                                  padding:
//                                                      const EdgeInsets.fromLTRB(
//                                                          50.0, 50.0, 0, 0),
//                                                  child: TextFormField(
//                                                    keyboardType:
//                                                        TextInputType.multiline,
//                                                    maxLines: null,
//                                                    autofocus: true,
//                                                    style: kHeadLineTextStyle,
//                                                    decoration: InputDecoration(
//                                                        labelText:
//                                                            'Your thoughts here...',
//                                                        labelStyle:
//                                                            kLabelTextStyle),
//                                                  ),
//                                                )
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  Step(
//                                    title: const Text(''),
//                                    isActive: activeStates[3],
//                                    state: stepStates[3],
//                                    content: Column(
//                                      children: [
//                                        Padding(
//                                          padding: const EdgeInsets.symmetric(
//                                              vertical: 38.0),
//                                          child: Align(
//                                            alignment: Alignment.centerLeft,
//                                            child: titles[i + 3],
//                                          ),
//                                        ),
//                                        DecoratedBox(
//                                          decoration: cardBoxDecoration(),
//                                          child: Padding(
//                                            padding: const EdgeInsets.all(72.0),
//                                            child: Column(
//                                              children: <Widget>[
//                                                ListTile(
//                                                  leading: CircleAvatar(
//                                                    radius: 50.0,
//                                                    foregroundColor:
//                                                        kDarkBlueColor,
//                                                    child: Text(
//                                                      (i + 4).toString(),
//                                                      style: TextStyle(
//                                                          color: Colors.white,
//                                                          fontSize: 48,
//                                                          fontWeight:
//                                                              FontWeight.w900),
//                                                    ),
//                                                    backgroundColor:
//                                                        kDarkBlueColor,
//                                                  ),
//                                                  title: Text(
//                                                    exercises[i + 3]
//                                                        .instructions[i + 3]
//                                                        .detail,
//                                                    style: kHeadLineTextStyle,
//                                                  ),
//                                                ),
//                                                Padding(
//                                                  padding:
//                                                      const EdgeInsets.fromLTRB(
//                                                          50.0, 50.0, 0, 0),
//                                                  child: TextFormField(
//                                                    keyboardType:
//                                                        TextInputType.multiline,
//                                                    maxLines: null,
//                                                    autofocus: true,
//                                                    style: kHeadLineTextStyle,
//                                                    decoration: InputDecoration(
//                                                        labelText:
//                                                            'Your thoughts here...',
//                                                        labelStyle:
//                                                            kLabelTextStyle),
//                                                  ),
//                                                )
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                ],
//                              );
//                            },
//                          )),
//                    ),
//            ],
//          ),
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(
//          Icons.list,
//        ),
//        onPressed: switchStepType,
//      ),
//    );
//  }
//
//  next() {
//    if (currentStep + 1 != steps.length) {
//      goTo(currentStep + 1);
//    } else {
//      setState(() {
//        i += 1;
//        complete = true;
//        print("currentStep = $currentStep  i = $i");
//        for (int i = 0; i < activeStates.length; i++) {
//          activeStates[i] = currentStep == i;
//        }
//        stepStates[i] =
//            currentStep >= i ? StepState.complete : StepState.indexed;
//      });
//    }
//  }
//
//  cancel() {
//    if (currentStep > 0) {
//      setState(() {
//        i -= 1;
//      });
//      goTo(currentStep - 1);
//    }
//  }
//
//  goTo(int step) {
//    setState(() {
//      i = step;
//      currentStep = step;
//      print("currentStep = $currentStep  i = $i");
//      for (int i = 0; i < activeStates.length; i++) {
//        activeStates[i] = currentStep == i;
//      }
//      stepStates[i] = currentStep >= i ? StepState.complete : StepState.indexed;
//    });
//  }
//
//  StepperType stepperType = StepperType.horizontal;
//
//  switchStepType() {
//    setState(() => stepperType == StepperType.horizontal
//        ? stepperType = StepperType.vertical
//        : stepperType = StepperType.horizontal);
//  }
//}
