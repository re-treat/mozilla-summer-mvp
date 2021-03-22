import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';

class CreateStoryCard extends StatelessWidget{
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Post my story",
          style: kTitleTextStyle,
        ),
        Text(
          "Tell your story: "
        ),
        TextField(),
        DropdownButton(
            items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
        )
      ],
    );
  }
}