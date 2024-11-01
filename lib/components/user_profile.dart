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
  List<dynamic> role = [""];
  var since = "";
  User? user;
  late Future<void> userFuture;

  @override
  void initState() {
    super.initState();
    // Appeler initializeUser une seule fois dans initState
    userFuture = initializeUser();
  }

  Future<void> initializeUser() async {
    var user = await ApiController.getUserProfileFromUsername(widget.username);
    if (user.username != "L'utilisateur n'existe pas") {
      setState(() {
        this.user = user;
        this.name = user.username.toString();
        this.imageUrl = user.imageUrl.toString();
        this.role = user.workPlaces;
        this.since = user.since.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done && user != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProfilePicture(user: user!, widget: widget),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (role.isNotEmpty && role[0] != "")
                  for (var r in role) Text(r),
                Text(
                  "Inscrite en $since",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            );
          } else {
            return const Text("Erreur lors du chargement de l'utilisateur");
          }
        },
      ),
    );
  }
}
