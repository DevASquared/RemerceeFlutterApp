import 'package:flutter/material.dart';

class ActionText extends StatelessWidget {
  final String text;

  const ActionText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
