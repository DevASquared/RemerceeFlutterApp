import 'package:flutter/material.dart';
import 'package:remercee/utils/colors.dart';

class NavBar extends StatefulWidget {
  final int index;
  final void Function(dynamic index) event;

  const NavBar({
    required this.index,
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double pos = 0;
  int selectedIndex = 0; // Nouvelle variable pour stocker l'index sélectionné

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index; // Initialise selectedIndex avec l'index fourni
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var width = MediaQuery.of(context).size.width;
    var iconSize = width * 0.09;
    var circleSize = iconSize * 1.5;
    pos = changePos(selectedIndex, width, iconSize, circleSize);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 24;
    var iconSize = width * 0.09;
    var containerHeight = iconSize * 2;
    var circleSize = iconSize * 1.5;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: containerHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 6),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: iconSize,
                    icon: Icon(
                      Icons.manage_search_rounded,
                      color: selectedIndex == 0 ? AppColors.red : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        pos = changePos(0, width, iconSize, circleSize);
                        selectedIndex = 0; // Mets à jour selectedIndex
                        widget.event(0);
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: iconSize,
                    icon: Icon(
                      Icons.qr_code_scanner_rounded,
                      color: selectedIndex == 1 ? AppColors.red : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        pos = changePos(1, width, iconSize, circleSize);
                        selectedIndex = 1; // Mets à jour selectedIndex
                        widget.event(1);
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: iconSize,
                    icon: Icon(
                      Icons.account_circle_outlined,
                      color: selectedIndex == 2 ? AppColors.red : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        pos = changePos(2, width, iconSize, circleSize);
                        selectedIndex = 2; // Mets à jour selectedIndex
                        widget.event(2);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  double changePos(int index, double width, double iconSize, double circleSize) {
    switch (index) {
      case 0:
        return (width / 6) - (circleSize - iconSize) / 2;
      case 1:
        return (width / 2) - (circleSize / 2);
      case 2:
        return (5 * width / 6) - (circleSize + iconSize) / 2;
      default:
        return 0;
    }
  }
}
