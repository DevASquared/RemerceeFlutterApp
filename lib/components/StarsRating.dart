import 'dart:developer';

import 'package:flutter/material.dart';

class StarsRating extends StatefulWidget {
  final double rate;

  const StarsRating({
    Key? key,
    required this.rate,
  }) : super(key: key);

  @override
  State<StarsRating> createState() => _starsRatingState();
}

class _starsRatingState extends State<StarsRating> {
  @override
  Widget build(BuildContext context) {
    final meanRate = widget.rate;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < meanRate.floor()) {
          // Étoiles pleines
          return const Icon(Icons.star, color: Color(0xFFEA2831), size: 30);
        } else if (index < meanRate && meanRate - index > 0) {
          // Demi-étoile
          return const Icon(Icons.star_half, color: Color(0xFFEA2831), size: 30,);
        } else {
          // Étoile vide
          return const Icon(Icons.star_border, color: Color(0xFFEA2831), size: 30);
        }
      }),
    );
  }
}
