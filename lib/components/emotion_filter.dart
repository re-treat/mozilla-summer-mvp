import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/components/httpUtil.dart' as httpUtil;

class EmotionFilterEntry {
  const EmotionFilterEntry(this.name);
  final String name;
}

class EmotionFilter extends StatefulWidget {
  @override
  State createState() => EmotionFilterState();
}

class EmotionFilterState extends State<EmotionFilter> {
  List<EmotionFilterEntry> _emotion;
  /*
  final List<EmotionFilterEntry> _emotion = <EmotionFilterEntry>[
    const EmotionFilterEntry('frustrated'),
    const EmotionFilterEntry('impatient'),
    const EmotionFilterEntry('angry'),
    const EmotionFilterEntry('disappointed'),
    const EmotionFilterEntry('regretful'),
    const EmotionFilterEntry('paralyzed'),
    const EmotionFilterEntry('pessimistic'),
    const EmotionFilterEntry('stressed'),
    const EmotionFilterEntry('vulnerable'),
    const EmotionFilterEntry('worried'),
    const EmotionFilterEntry('self-conscious'),
    const EmotionFilterEntry('guilty'),
  ];
  */
  List<String> _filters = <String>[];

  Stream<Widget> get emotionWidgets async* {
    List<EmotionFilterEntry> _emotion = <EmotionFilterEntry>[];
    await httpUtil.getLabels("q1").then((labels) => {
      labels.forEach((label) => {
        _emotion.add(EmotionFilterEntry(label))
      }),
    });
    for (final EmotionFilterEntry emotion in _emotion) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          selectedColor: kLightBlueColor,
          backgroundColor: kLightGrayColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          label: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Text(
              emotion.name,
              style: TextStyle(color: kDarkGrayColor),
            ),
          ),
          selected: _filters.contains(emotion.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(emotion.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == emotion.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: emotionWidgets.toList(),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot){
        if(snapshot.hasData){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Wrap(
                spacing: 12.0,
                runSpacing: 8.0,
                children: snapshot.data,
              )
            ]
        );
        }
        else if(snapshot.hasError){
          return Text(
            'Error loading labels.',
            textAlign: TextAlign.center,
          );
        }
        else{
          return Text(
            'Loading labels...',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
