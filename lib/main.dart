import 'package:flutter/material.dart';
import 'pages/RatingPage.dart';
import 'pages/ProfilePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Remercee',
      home: Rating(),
    );
  }
}
