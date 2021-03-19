import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'models/brain.dart';
import 'screens/emoji_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Brain(),
    child: ReTreatApp(),
  ));
}

class ReTreatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: EmojiPage(),
      ),
    );
  }
}
