import 'dart:developer';

import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final int index;

  const NavBar({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double pos = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var width = MediaQuery.of(context).size.width;
    var iconSize = width * 0.09;
    var circleSize = iconSize * 1.5;
    pos = changePos(widget.index, width, iconSize, circleSize);
  }

  @override
  Widget build(BuildContext context) {
    var index = widget.index;
    var width = MediaQuery.of(context).size.width;
    var iconSize = width * 0.09;
    var containerHeight = iconSize * 2;
    var circleSize = iconSize * 1.5;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: pos,
              child: Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFFEA2831),
                ),
              ),
            ),
            SizedBox(
              height: containerHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 6),
                child: Container(
                  // color: Colors.yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.black,
                          iconSize: iconSize,
                          icon: const Icon(Icons.manage_search_rounded),
                          onPressed: () {
                            setState(() {
                              pos = changePos(0, width, iconSize, circleSize);
                            });
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.black,
                          iconSize: iconSize,
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                          onPressed: () {
                            setState(() {
                              pos = changePos(1, width, iconSize, circleSize);
                            });
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.black,
                          iconSize: iconSize,
                          icon: const Icon(Icons.account_circle_outlined),
                          onPressed: () {
                            setState(() {
                              pos = changePos(2, width, iconSize, circleSize);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double changePos(int index, double width, double iconSize, double circleSize) {
    switch (index) {
      case 0:
        return (width / 6) - (circleSize - iconSize) / 2; // 65.33-(54-36)/2
      case 1:
        return (width / 2) - (circleSize / 2);
      case 2:
        return (5 * width / 6) - (circleSize + iconSize) / 2; // 3ème icône
      default:
        return 0;
    }
  }
}