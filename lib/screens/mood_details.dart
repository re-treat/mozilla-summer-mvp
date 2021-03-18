import 'package:flutter/material.dart';

import '../constants.dart';

final mood = moodMap['stressed'];


final TITLE = RichText(
  text: TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: kTitleTextStyle,
    children: <TextSpan>[
//        new TextSpan(text: '               '),
      TextSpan(text: '#' + EMOJI_STR, style: kTitleTextStyle),
      TextSpan(text: smile)
    ],
  ),
);