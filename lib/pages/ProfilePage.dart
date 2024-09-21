import 'package:flutter/material.dart';

import '../components/NavBar.dart';
import '../components/UserProfile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = "Sophie Turli";
  String userRole = "Restaurant la citadelle - Bordeaux";
  String userImageUrl = "https://media.istockphoto.com/id/1196391449/fr/photo/verticale-de-femme-africaine.jpg?s=612x612&w=0&k=20&c=Jz9UR3Qg0d6oe6-ETeK5zu8DhZXUB-YVod6EKEnH-tQ=";
  String userSince = "Inscrite en 2021";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remercee"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(  // Ajout de Center ici
            width: MediaQuery.of(context).size.width,
            child: UserProfile(
              imageUrl: userImageUrl,
              name: userName,
              role: userRole,
              since: userSince,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Récap des notes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
          )
        ],
      ),
    );
  }

}
