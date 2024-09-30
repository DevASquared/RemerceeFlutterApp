import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:remercee/components/profile_picture.dart';
import 'package:remercee/models/user_model.dart';
import 'package:remercee/utils/api_controller.dart';

class UserProfile extends StatefulWidget {
  final String? username;
  final bool public;

  const UserProfile({Key? key, required this.username, this.public = true}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var imageUrl = "";
  var name = "";
  List<String> role = [""];
  var since = "";
  late User user;

  @override
  void initState() {
    super.initState();
    log("Userprofile[25]: Used username : ${widget.username}"); // empty
    ApiController.getUserProfileFromUsername(widget.username).then(
      (user) {
        log("Userprofile[28]: Used username : ${widget.username}");
        log("Userprofile[29]: User username : ${user.username}");
        if (user.username != "L'utilisateur n'existe pas") {
          setState(() {
            user = user;
            name = user.username.toString();
            imageUrl = user.imageUrl.toString();
            role = user.places;
            since = user.since.year.toString();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProfilePicture(user: user, widget: widget),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (role != "")
            Text(
              role.join("\n"),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          Text(
            "Inscrite en $since",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
