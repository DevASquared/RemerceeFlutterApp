import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 11.5,
      child: Center(
        child: Text(
          "REMERCEE",
          style: GoogleFonts.inter(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
