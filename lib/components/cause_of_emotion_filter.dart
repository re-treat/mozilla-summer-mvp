import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/components/httpUtil.dart' as httpUtil;

class CauseOfEmotionFilterEntry {
  const CauseOfEmotionFilterEntry(this.name);
  final String name;
}

class CauseOfEmotionFilter extends StatefulWidget {
  @override
  State createState() => CauseOfEmotionFilterState();
}

class CauseOfEmotionFilterState extends State<CauseOfEmotionFilter> {
  List<String> _filters = <String>[];

  Stream<Widget> get causeOfEmotionWidgets async* {
    List<CauseOfEmotionFilterEntry> _cause = <CauseOfEmotionFilterEntry>[];
    await httpUtil.getLabels("q2").then((labels) => {
      labels.forEach((label) => {
        _cause.add(CauseOfEmotionFilterEntry(label))
      }),
    });
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
    return FutureBuilder<List<Widget>>(
      future: causeOfEmotionWidgets.toList(),
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
