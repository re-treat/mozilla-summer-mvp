import 'package:flutter/material.dart';

import 'screens/input_page.dart';

void main() {
  runApp(ReTreatApp());
}

class ReTreatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: InputPage(),
    );
  }
}
