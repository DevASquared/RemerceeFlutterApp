import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserRating extends StatefulWidget {
  final double rate;

  final void Function(double rate) event;

  const UserRating({
    Key? key,
    required this.rate,
    required this.event,
  }) : super(key: key);

  @override
  State<UserRating> createState() => _UserRatingState();
}

class _UserRatingState extends State<UserRating> {
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
        itemSize: MediaQuery.of(context).size.width * 0.125,
        ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star_rounded,
              color: Color(0xFFEA2831),
            ),
            half: const Icon(
              Icons.star_half_rounded,
              color: Color(0xFFEA2831),
            ),
            empty: const Icon(
              Icons.star_border_rounded,
              color: Color(0xFFEA2831),
            )),
        onRatingUpdate: (double value) {
          rate = value;
          widget.event(rate);
        },
      ),
    );
  }
}
