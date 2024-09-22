import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var x = "Page Fonctionne";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(x, style: const TextStyle(fontSize: 25)),
      ),
    );
  }
}
