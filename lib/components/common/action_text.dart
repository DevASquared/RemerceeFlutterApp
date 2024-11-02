import 'package:flutter/material.dart';
import 'package:remercee/utils/colors.dart';

class ActionText extends StatelessWidget {
  final String text;

  final bool? primary;

  final void Function() onTap;

  const ActionText({
    super.key,
    required this.text,
    this.primary, required this. onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (primary == null || primary == false) ? Colors.transparent : AppColors.red,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Text(
            text,
            style: TextStyle(
              color: (primary == null || primary == false) ? AppColors.red : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
