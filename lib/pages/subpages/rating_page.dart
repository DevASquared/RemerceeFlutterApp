import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:remercee/components/common/NavBar.dart';
import 'package:remercee/components/UserRating.dart';
import 'package:remercee/components/common/header.dart';
import 'package:remercee/utils/api_controller.dart';
import 'package:remercee/utils/colors.dart';
import '../../components/user_profile.dart';
import '../../models/user_model.dart';

class RatingPage extends StatefulWidget {
  final String username;
  final void Function() onerror;

  const RatingPage({super.key, required this.username, required this.onerror});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  String userName = "";
  String userPlace = "";
  String userImageUrl =
      "https://media.istockphoto.com/id/1196391449/fr/photo/verticale-de-femme-africaine.jpg?s=612x612&w=0&k=20&c=Jz9UR3Qg0d6oe6-ETeK5zu8DhZXUB-YVod6EKEnH-tQ=";
  String userSince = "Inscrite en 2021";
  double rate = 0;
  bool error = false;

  @override
  void initState() {
    super.initState();
    log(widget.username);
    ApiController.getUserProfileFromUsername(widget.username).then(
      (user) {
        if (user.email == "error") {
          setState(() {
            error = true;
          });
        }
        setData(user);
      },
    );
  }

  void setData(User user) {
    setState(() {
      userName = user.username;
      userPlace = user.place;
      userImageUrl = user.imageUrl;
      userSince = user.since.year.toString();
    });
    /*int i;
        for(i = 0; i < user.notes.length; i++) {
          rate += user.notes[i];
        }
        rate /= i;*/
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.2,
      width: MediaQuery.of(context).size.width / 1.2,
      child: error
          ? Column(
              children: [
                Spacer(),
                Text(
                  "Une erreur est parvenue !",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.065, // Prend toute la largeur
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onerror();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                    ),
                    child: const Text(
                      "Retour",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            )
          : Column(
              children: <Widget>[
                UserProfile(
                  username: userName.isNotEmpty ? userName : 'Chargement...',
                  public: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.271 / 2,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.115,
                  child: Column(
                    children: [
                      Text(
                        userName.isNotEmpty
                            ? "Comment noteriez-vous $userName"
                            : "Comment noteriez-vous l'utilisateur ?", // Affiche un message générique si userName est vide
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
            ),
    );
  }
}
