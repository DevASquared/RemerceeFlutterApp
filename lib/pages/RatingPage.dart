import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:remercee/components/UserRating.dart';
import '../components/UserProfile.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  String userName = "Sophie Turli";
  String userRole = "Restaurant la citadelle - Bordeaux";
  String userImageUrl =
      "https://media.istockphoto.com/id/1196391449/fr/photo/verticale-de-femme-africaine.jpg?s=612x612&w=0&k=20&c=Jz9UR3Qg0d6oe6-ETeK5zu8DhZXUB-YVod6EKEnH-tQ=";
  String userSince = "Inscrite en 2021";
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remercee"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            UserProfile(
              imageUrl: userImageUrl,
              name: userName,
              role: userRole,
              since: userSince,
            ),
            const SizedBox(height: 40),
            Text(
              'Comment noteriez-vous $userName ?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            UserRating(rate: 3),
            const SizedBox(height: 100), // Ajout d'un espacement
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,// Prend toute la largeur
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEA2831),
                ),
                child: const Text(
                  "Envoyer",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
