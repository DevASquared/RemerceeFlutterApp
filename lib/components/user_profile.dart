import 'dart:developer';

import 'package:flutter/material.dart';
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
  var role = "";
  var since = "";

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
            name = user.username.toString();
            imageUrl = user.imageUrl.toString();
            role = user.place;
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
          GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: imageUrl == ""
                  ? widget.public
                      ? Container()
                      : const Icon(Icons.edit)
                  : Image.network(
                      imageUrl,
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return const Icon(Icons.broken_image);
                      },
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.height * 0.15,
                      height: MediaQuery.of(context).size.height * 0.15,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (role != "")
            Text(
              role,
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
