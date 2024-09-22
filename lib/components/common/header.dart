import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 11.5,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
          ),
          Text(
            "REMERCEE",
            style: GoogleFonts.inter(
              fontSize: 24,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.output_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
