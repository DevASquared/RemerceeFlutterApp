import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:remercee/components/common/NavBar.dart';
import 'package:remercee/components/UserRating.dart';
import 'package:remercee/components/common/header.dart';
import 'package:remercee/utils/colors.dart';
import '../../components/user_profile.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  String userName = "Sophie Turli";
  String userPlace = "Restaurant la citadelle - Bordeaux";
  String userImageUrl =
      "https://media.istockphoto.com/id/1196391449/fr/photo/verticale-de-femme-africaine.jpg?s=612x612&w=0&k=20&c=Jz9UR3Qg0d6oe6-ETeK5zu8DhZXUB-YVod6EKEnH-tQ=";
  String userSince = "Inscrite en 2021";
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserProfile(
          imageUrl: userImageUrl,
          name: userName,
          place: userPlace,
          since: userSince,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.271 / 2,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.115,
          child: Column(
            children: [
              Text(
                'Comment noteriez-vous $userName ?',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              const UserRating(rate: 3), // Ajout d'un espacement
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.271 / 2,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.065, // Prend toute la largeur
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
        ),
      ],
    );
  }
}
