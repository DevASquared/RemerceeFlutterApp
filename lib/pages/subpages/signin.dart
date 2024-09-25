import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:remercee/utils/colors.dart';
import 'package:remercee/utils/constants.dart';

import '../../utils/api_controller.dart';

class Signin extends StatefulWidget {
  final void Function() event;

  const Signin({super.key, required this.event});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

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
                'Se connecter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Username Field
                    TextFormField(
                      cursorColor: Colors.red, // Couleur du curseur
                      decoration: InputDecoration(
                        hintText: 'Username', // Utiliser hintText à la place de labelText
                        filled: true,
                        fillColor: const Color(0xFFEEEEEE),
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
                    TextFormField(
                      cursorColor: Colors.red, // Couleur du curseur
                      decoration: InputDecoration(
                        hintText: 'Password', // Utiliser hintText
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
                    const SizedBox(height: 100),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width, // Le bouton prend toute la largeur
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var result = await http.post(
                              Uri.parse("${ApiController.url}auth/login"),
                              body: {
                                "username": _username,
                                "pass": sha256.convert(utf8.encode(_password)).toString(),
                              },
                            );
                            var success = bool.parse(json.decode(result.body.toString())["success"]["hasData"].toString());
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
                        child: Text(
                          'Login',
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
                                text: 'Don’t have an account? ',
                                style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.5)),
                              ),
                              TextSpan(
                                text: 'Sign In',
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
}
