import 'package:flutter/material.dart';
import 'package:remercee/pages/subpages/rating_page.dart';
import 'package:remercee/pages/subpages/scan_page.dart';
import 'package:remercee/pages/subpages/signin.dart';
import 'package:remercee/pages/subpages/signup.dart';
import 'package:remercee/utils/constants.dart';

import '../components/common/NavBar.dart';
import '../components/common/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget actualSubPage = const Spacer();

  void changeAuth(int index) {
    setState(() {
      if (index == 0) {
        actualSubPage = Signup(event: () => changeAuth(1));
      } else {
        actualSubPage = Signin(event: () => changeAuth(0));
      }
    });
  }

  void changePage(int index) {
    setState(() {
      switch(index) {
        case 0:
          actualSubPage = const Center(child: Text("Under Construction", style: TextStyle(fontSize: 25)));
          break;
        case 1:
          actualSubPage = const ScanPage();
          break;
      }
    });
  }

  @override
  void initState() {
    Constants.isConnected().then((value) {
      setState(() {
        if (value) {
          actualSubPage = const RatingPage();
        } else {
          changeAuth(1);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;
    final height = MediaQuery.of(context).size.height - safePadding;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Header(),
              actualSubPage,
              NavBar(index: 2, event: (index) {
                changePage(index);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
