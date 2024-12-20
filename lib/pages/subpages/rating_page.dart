import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remercee/components/common/NavBar.dart';
import 'package:remercee/components/user_rating.dart';
import 'package:remercee/components/common/header.dart';
import 'package:remercee/utils/api_controller.dart';
import 'package:remercee/utils/colors.dart';
import '../../components/user_profile.dart';
import '../../models/user_model.dart';

class RatingPage extends StatefulWidget {
  final String username;
  final void Function() onerror;
  final void Function() closePage;

  const RatingPage({
    super.key,
    required this.username,
    required this.onerror,
    required this.closePage,
  });

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  String userName = "";
  List<dynamic> userPlace = [""];
  String userImageUrl = "";
  String userSince = "";
  double rate = 3;
  bool error = false;
  Widget userprofile = const UserProfile(
    username: "",
    public: true,
  );

  @override
  void initState() {
    super.initState();
    ApiController.getUserProfileFromUsername(widget.username).then(
      (user) {
        if (user.email == "error") {
          setState(() {
            error = true;
          });
        } else {
          if (user.username != "L'utilisateur n'existe pas") {
            setState(() {
              userName = user.username;
              userPlace = user.workPlaces;
              userImageUrl = user.imageUrl;
              userSince = user.since.year.toString();
              userprofile = UserProfile(
                username: userName,
                public: true,
              );
            });
          }
        }
      },
    );
  }

  Future<User> getData() async {
    User user = await ApiController.getUserProfileFromUsername(widget.username);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.2,
      width: MediaQuery.of(context).size.width / 1.2,
      child: error
          ? Column(
              children: [
                const Spacer(),
                const Text(
                  "Une erreur est parvenue !",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
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
                const Spacer(),
              ],
            )
          : Column(
              children: <Widget>[
                FutureBuilder<User>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Affiche un indicateur de chargement pendant le chargement des données
                    } else if (snapshot.hasError) {
                      return const Text("Une erreur est survenue");
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return UserProfile(
                        username: snapshot.data!.username,
                        public: true,
                      );
                    } else {
                      return const Text("Utilisateur non trouvé");
                    }
                  },
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
                            ? "Comment noteriez-vous $userName ?"
                            : "Comment noteriez-vous l'utilisateur ?", // Affiche un message générique si userName est vide
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      UserRating(
                        rate: 3,
                        event: (rate) {
                          this.rate = rate;
                        },
                      ),
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
                    onPressed: () async {
                      bool canRate = await ApiController.rateUser(userName, rate);
                      if (canRate) {
                        widget.closePage();
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Erreur"),
                              content: Text("Vous ne pouvez voter pour la même personne qu'une fois toutes les 16 heures"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    widget.closePage();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );

                      }
                    },

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
