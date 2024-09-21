import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserRating extends StatefulWidget {
  final double rate;

  const UserRating({
    Key? key,
    required this.rate,
  }) : super(key: key);

  @override
  State<UserRating> createState() => _userRatingState();
}

class _userRatingState extends State<UserRating> {
  @override
  Widget build(BuildContext context) {
    var rate = widget.rate;

    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: RatingBar(
        minRating: 0,
        maxRating: 5,
        initialRating: rate,
        allowHalfRating: true,
        itemSize: MediaQuery.of(context).size.width * 0.16,
        ratingWidget: RatingWidget(
            full: Icon(
              Icons.star,
              color: Color(0xFFEA2831),
            ),
            half: Icon(
              Icons.star_half,
              color: Color(0xFFEA2831),
            ),
            empty: Icon(
              Icons.star_border,
              color: Color(0xFFEA2831),
            )),
        onRatingUpdate: (double value) {
          rate = value;
        },
      ),
    );
  }
}
