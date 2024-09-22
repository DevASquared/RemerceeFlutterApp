import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static Future<bool> isConnected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("connected") ?? false;
  }
}
