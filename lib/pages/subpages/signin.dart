import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:remercee/utils/api_controller.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class Signin extends StatefulWidget {
  final void Function() event;

  final FToast fToast;

  const Signin({super.key, required this.event, required this.fToast});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Créer un compte',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Column(
                  children: [
                    // Username Field
                    TextFormField(
                      cursorColor: Colors.red, // Couleur du curseur
                      validator: usernameValidator,
                      decoration: InputDecoration(
                        hintText: "Nom d'utilisateur", // Utiliser hintText à la place de labelText
                        filled: true,
                        fillColor: Color(0xFFEEEEEE),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12), // Bordures arrondies
                          borderSide: BorderSide.none, // Supprimer la bordure
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    TextFormField(
                      cursorColor: Colors.red, // Couleur du curseur
                      validator: emailValidator,
                      decoration: InputDecoration(
                        hintText: 'Email', // Utiliser hintText
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12), // Bordures arrondies
                          borderSide: BorderSide.none, // Supprimer la bordure
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    TextFormField(
                      cursorColor: Colors.red,
                      // Couleur du curseur
                      validator: passwordValidator,
                      decoration: InputDecoration(
                        hintText: 'Mot de passe', // Utiliser hintText
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12), // Bordures arrondies
                          borderSide: BorderSide.none, // Supprimer la bordure
                        ),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password Field
                    TextFormField(
                      cursorColor: Colors.red, // Couleur du curseur
                      decoration: InputDecoration(
                        hintText: 'Confirmer le mot de passe', // Utiliser hintText
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12), // Bordures arrondies
                          borderSide: BorderSide.none, // Supprimer la bordure
                        ),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = value;
                        });
                      },
                    ),
                    const SizedBox(height: 50),

                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width, // Le bouton prend toute la largeur
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_username.length <= 3) {
                              Constants.showNotConnectedToast(widget.fToast, "Le nom d'utilisateur est incorrecte");
                              return;
                            } else if (!EmailValidator.validate(_email) && _email.length <= 3) {
                              Constants.showNotConnectedToast(widget.fToast, "L'email est incorrecte");
                              return;
                            } else if (_password.length <= 3) {
                              Constants.showNotConnectedToast(widget.fToast, "Le password est incorrecte");
                              return;
                            } else if(_password != _confirmPassword) {
                              Constants.showNotConnectedToast(widget.fToast, "La confirmation est incorrecte");
                              return;
                            }
                            var result = await http.post(
                              Uri.parse("${ApiController.url}auth/register"),
                              body: {
                                "username": _username,
                                "email": _email,
                                "pass": sha256.convert(utf8.encode(_password)).toString(),
                                "imageUrl": "",
                              },
                            );
                            var success = bool.parse(json.decode(result.body.toString())["success"].toString());
                            if (success) {
                              Constants.getPreferences().then(
                                (sharedPreferences) {
                                  sharedPreferences.setBool("connected", true);
                                  sharedPreferences.setString("username", _username);
                                  widget.event();
                                },
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Inscription',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () {
                          widget.event();
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Vous avez déjà un compte? ',
                                style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.5)),
                              ),
                              TextSpan(
                                text: 'Connexion',
                                style: TextStyle(fontSize: 18, color: AppColors.red, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? emailValidator(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value) ? 'Adresse email invalide' : null;
  }

  String? usernameValidator(String? value) {
    value = value ?? "";
    return value.isEmpty || value.length <= 3 ? "Nom d'utilisateur invalide" : null;
  }

  String? passwordValidator(String? value) {
    value = value ?? "";
    return value.isEmpty || value.length <= 8 ? "8 caratères minimum" : null;
  }
}
