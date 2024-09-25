import 'package:flutter/material.dart';
import 'package:remercee/pages/subpages/profile_page.dart';
import 'package:remercee/pages/subpages/qr_code_page.dart';
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
  bool isNavigating = false;

  void changeAuth(int index) {
    if (!isNavigating) {
      setState(() {
        isNavigating = true;
        Constants.getPreferences().then(
          (preferences) {
            if (!preferences.containsKey("connected") || preferences.getBool("connected")! == false) {
              if (index == 0) {
                actualSubPage = Signup(event: () => changeAuth(1));
              } else {
                actualSubPage = Signin(event: () => changeAuth(0));
              }
            } else {
              actualSubPage = const ProfilePage();
            }
            isNavigating = false;
          },
        );
      });
    }
  }

  void changePage(int index) {
    if (!isNavigating) {
      // Empêche l'appel multiple à setState
      setState(() {
        isNavigating = true;
        switch (index) {
          case 0:
            actualSubPage = const Center(child: Text("Under Construction", style: TextStyle(fontSize: 25)));
            break;
          case 1:
            actualSubPage = ScanPage(event: (username) {
              setState(() {
                actualSubPage = RatingPage(
                  username: username,
                  onerror: () {
                    changePage(1);
                  },
                  closePage: () {
                    changePage(1);
                  },
                );
              });
            });
            break;
          case 2:
            changeAuth(1);
            break;
          case 5:
            actualSubPage = const QrCodePage();
        }
        isNavigating = false;
      });
    }
  }

  @override
  void initState() {
    Constants.isConnected().then((value) {
      setState(() {
        if (value) {
          actualSubPage = ScanPage(event: (username) {
            setState(() {
              actualSubPage = RatingPage(
                username: username,
                onerror: () {
                  changePage(1);
                },
                closePage: () {
                  changePage(1);
                },
              );
            });
          });
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
              Header(logout: () => changeAuth(0), showQrCode: () => changePage(5)),
              actualSubPage,
              NavBar(
                index: 1,
                event: (index) {
                  changePage(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
