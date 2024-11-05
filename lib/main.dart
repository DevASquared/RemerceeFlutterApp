import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remercee/pages/edit_page.dart';
import 'package:remercee/pages/home_page.dart';
import 'package:remercee/pages/subpages/rating_page.dart';

import 'models/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      title: 'Remercee',
      // home: EditPage(
      //     user: User(
      //         username: "Antonin",
      //         since: DateTime.now(),
      //         email: "antonindosouto@gmail.com",
      //         imageUrl: "https://firebasestorage.googleapis.com/v0/b/remercee-project.appspot.com/o/Antonin.jpg?alt=media",
      //         workPlaces: [""], dynamicNotes: []),),
      home: const HomePage(),
      // home: RatingPage(username: 'Antonin', onerror: () {  }, closePage: () {  },)
    );
  }
}
