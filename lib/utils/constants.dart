import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static Future<bool> isConnected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("connected") ?? false;
  }

  static Future<SharedPreferences> getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static void showNotConnectedToast(FToast fToast, String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded),
          const SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );

  }
}
