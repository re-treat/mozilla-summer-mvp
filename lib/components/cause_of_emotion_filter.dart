import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';

class CauseOfEmotionFilterEntry {
  const CauseOfEmotionFilterEntry(this.name);
  final String name;
}

class CauseOfEmotionFilter extends StatefulWidget {
  @override
  State createState() => CauseOfEmotionFilterState();
}

class CauseOfEmotionFilterState extends State<CauseOfEmotionFilter> {
  final List<CauseOfEmotionFilterEntry> _cause = <CauseOfEmotionFilterEntry>[
    const CauseOfEmotionFilterEntry('work'),
    const CauseOfEmotionFilterEntry('school'),
    const CauseOfEmotionFilterEntry('finance'),
    const CauseOfEmotionFilterEntry('relationship'),
  ];
  List<String> _filters = <String>[];

  Iterable<Widget> get causeOfEmotionWidgets sync* {
    for (final CauseOfEmotionFilterEntry cause in _cause) {
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
              cause.name,
              style: TextStyle(color: kDarkGrayColor),
            ),
          ),
          selected: _filters.contains(cause.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(cause.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == cause.name;
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
          children: causeOfEmotionWidgets.toList(),
        ),
//        Text('Look for: ${_filters.join(', ')}'),
      ],
    );
  }
}
