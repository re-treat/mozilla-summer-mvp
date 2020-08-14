import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';

class EmotionFilterEntry {
  const EmotionFilterEntry(this.name);
  final String name;
}

class EmotionFilter extends StatefulWidget {
  @override
  State createState() => EmotionFilterState();
}

class EmotionFilterState extends State<EmotionFilter> {
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
  List<String> _filters = <String>[];

  Iterable<Widget> get emotionWidgets sync* {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          spacing: 12.0,
          runSpacing: 8.0,
          children: emotionWidgets.toList(),
        ),
        //  Text('Look for: ${_filters.join(', ')}'),
      ],
    );
  }
}
