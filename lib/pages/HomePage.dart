import 'package:flutter/material.dart';
import '../components/NavBar.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page avec NavBar'),
      ),
      body: Stack(
        children: <Widget>[
          // Le contenu principal de la page peut aller ici
          Positioned.fill(
            child: Column(
              children: <Widget>[
                // Exemple de contenu
                Expanded(
                  child: Center(
                    child: Text(
                      'Contenu principal',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // NavBar placée en bas
          Align(
            alignment: Alignment.bottomCenter,
            child: const NavBar(index: 2),
          ),
        ],
      ),
    );
  }
}
