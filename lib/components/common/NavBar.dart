import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:remercee/utils/colors.dart';

class NavBar extends StatefulWidget {
  final int index;
  final void Function(int index, int selectedIndex) event;

  const NavBar({
    Key? key,
    required this.index,
    required this.event,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double pos = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 24;
    var iconSize = width * 0.09;
    var containerHeight = iconSize * 2;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: containerHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Remplacer l'icône de QR code par une icône "edit"
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: iconSize,
                  icon: Icon(
                    Icons.qr_code_2_rounded,  // Icône d'édition
                    color: widget.index == 0 ? AppColors.red : Colors.black,
                  ),
                  onPressed: () {
                    widget.event(0, selectedIndex);  // Mettre à jour l'index pour la page Edit
                  },
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: iconSize,
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: widget.index == 1 ? AppColors.red : Colors.black,
                  ),
                  onPressed: () {
                    widget.event(1, selectedIndex);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
