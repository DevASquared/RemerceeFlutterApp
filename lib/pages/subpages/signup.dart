import 'dart:developer';

import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class Signup extends StatefulWidget {
  final void Function() event;


  const Signup({super.key, required this.event});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                key: _formKey,
                child: Column(
                  children: [
                    // Username Field
                    TextFormField(
                      cursorColor: Colors.red, // Couleur du curseur
                      decoration: InputDecoration(
                        hintText: 'Username', // Utiliser hintText à la place de labelText
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
                    SizedBox(height: 16),

                    // Email Field
                    TextFormField(
                      cursorColor: Colors.red, // Couleur du curseur
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
                    SizedBox(height: 16),

                    // Password Field
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
                    SizedBox(height: 16),

                    // Confirm Password Field
                    TextFormField(
                      cursorColor: Colors.red, // Couleur du curseur
                      decoration: InputDecoration(
                        hintText: 'Confirm password', // Utiliser hintText
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Perform sign up logic
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Sign in',
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
                                text: 'Already have an account? ',
                                style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.5)),
                              ),
                              TextSpan(
                                text: 'Login',
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
