import 'package:flutter/material.dart';
import 'pages/home_pege.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DiceRollerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
