import 'package:flutter/material.dart';
import 'package:remercee/pages/subpages/rating_page.dart';
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

  void changePage(int index) {
    if (index == 0) {
      setState(() {
        actualSubPage = Signup(event: () {
          changePage(1);
        });
      });
    } else {
      setState(() {
        actualSubPage = Signin(event: () {
          changePage(0);
        });
      });
    }
    // return index == 0
    //     ? Signup(event: () {
    //         setState(() {
    //           changePage(0);
    //         });
    //       })
    //     : Signin(event: () {
    //         setState(() {
    //           changePage(0);
    //         });
    //       });
  }

  @override
  void initState() {
    Constants.isConnected().then((value) {
      setState(() {
        if (value) {
          actualSubPage = const RatingPage();
        } else {
          changePage(1);
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
              const NavBar(index: 2),
            ],
          ),
        ),
      ),
    );
  }
}
