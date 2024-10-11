import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:remercee/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class ApiController {
  // static const String url = "https://remerceeapi-yutru3qk.b4a.run/";
  static const String url = "http://localhost:1234/";

  static Future<User> getUserProfileFromUsername(username) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    username = (username == null) ? sharedPreferences.getString("username") : username;
    log("ApiController[15]: Username used in API call: $username");

    var result = await http.get(Uri.parse("${url}user?username=$username"));
    var jsonResult = json.decode(result.body.toString());

    if (bool.parse(jsonResult["success"].toString())) {
      var user = jsonResult["user"];
      return User(
        email: user["email"],
        username: user["username"],
        imageUrl: user["imageUrl"],
        places: user["role"],
        dynamicNotes: user["notes"],
        since: DateTime.fromMillisecondsSinceEpoch(user["since"]),
      );
    } else {
      return User(email: "error", username: "L'utilisateur n'existe pas", dynamicNotes: [], since: DateTime.now());
    }
  }

  static Future<bool> rateUser(username, rate) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var judge = sharedPreferences.getString("username");

    var result = await http.post(
      Uri.parse("${url}user/rate"),
      body: {
        "username": username.toString(),
        "rate": rate.toString(),
        "judge": judge.toString(),
      },
    );
    var jsonResult = json.decode(result.body.toString());
    return bool.parse(jsonResult["success"].toString());
  }

  static Future<void> login(widget, formKey, username, password) async {
    if (formKey.currentState!.validate()) {
      var result = await http.post(
        Uri.parse("${ApiController.url}auth/login"),
        body: {
          "username": username,
          "pass": sha256.convert(utf8.encode(password)).toString(),
        },
      );
      try {
        var decodedBody = json.decode(result.body.toString());
        var success = bool.parse(decodedBody["success"].toString());
        log(success.toString());
        if (success) {
          Constants.getPreferences().then(
            (sharedPreferences) {
              sharedPreferences.setBool("connected", true);
              sharedPreferences.setString("username", username);
              widget.event();
            },
          );
        } else {
          throw Error();
        }
      } catch (e) {
        Constants.showNotConnectedToast(widget.fToast, "Erreur de connection");
      }
    }
  }
}
