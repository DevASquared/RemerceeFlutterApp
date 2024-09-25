import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:remercee/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        place: user["role"],
        // notes: user["notes"].toString(),
        since: DateTime.fromMillisecondsSinceEpoch(user["since"]),
      );
    } else {
      return User(email: "error", username: "L'utilisateur n'existe pas", /*notes: [],*/ since: DateTime.now());
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
}
