import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remercee/pages/subpages/profile_page.dart';
import 'package:remercee/pages/subpages/qr_code_page.dart';
import 'package:remercee/pages/subpages/rating_page.dart';
import 'package:remercee/pages/subpages/scan_page.dart';
import 'package:remercee/pages/subpages/login.dart';
import 'package:remercee/pages/subpages/signin.dart';
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
  int cursorIndex = 1;
  bool connected = false;
  late FToast fToast;

  void changeAuth(int index) {
    log("Change Auth");
    log("Is Navigating : $isNavigating");
    setState(() {
      isNavigating = true;
      Constants.getPreferences().then(
        (preferences) {
          setState(() {
            cursorIndex = 1;
          });
          if (!preferences.containsKey("connected") || preferences.getBool("connected")! == false) {
            if (index == 0) {
              actualSubPage = Signin(event: () => changeAuth(1), fToast: fToast);
            } else {
              actualSubPage = Login(event: () => changeAuth(0), fToast: fToast);
            }
          } else {
            actualSubPage = const ProfilePage();
          }
          isNavigating = false;
        },
      );
    });
  }

  void changePage(int index) {
    if (!isNavigating) {
      setState(() async {
        isNavigating = true;
        switch (index) {
          case 0:
            if (await Constants.isConnected()) {
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
              Constants.showNotConnectedToast(fToast, "Vous n'êtes pas connecté !");
            }
            break;
          case 1:
            log("Change page");
            changeAuth(1);
            break;
          case 2:
            actualSubPage = const QrCodePage();
        }
        isNavigating = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    Constants.isConnected().then((value) {
      setState(() {
        log("Value : $value");
        if (value) {
          setState(() {
            cursorIndex = 1;
          });
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
          setState(() {
            cursorIndex = 1;
          });
          changeAuth(1);
          log("Cursor index : $cursorIndex");
        }
      });
    });
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
              Header(logout: () => changeAuth(0), showQrCode: () => changePage(2), fToast: fToast),
              actualSubPage,
              NavBar(
                index: cursorIndex,
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
