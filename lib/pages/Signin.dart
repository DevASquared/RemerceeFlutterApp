import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Se connecter',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 80),
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

                      // Sign Up Button taking full width
                      SizedBox(
                        width: double.infinity,
                        height: 50,// Le bouton prend toute la largeur
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Perform sign up logic
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                            ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
