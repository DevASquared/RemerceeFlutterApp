import 'package:flutter/material.dart';

class AddWorkPlacePopup extends StatefulWidget {
  final Function(String) onAddWorkPlace;

  const AddWorkPlacePopup({required this.onAddWorkPlace, super.key});

  @override
  State<AddWorkPlacePopup> createState() => _AddWorkPlacePopupState();
}

class _AddWorkPlacePopupState extends State<AddWorkPlacePopup> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text('Ajouter un endroit de travail', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.location_on),
              border: OutlineInputBorder(),
              hintText: 'Entrer un endroit',
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.05, // Prend toute la largeur
            child: ElevatedButton(
              onPressed: () {
                String newWorkPlace = _controller.text;
                if (newWorkPlace.isNotEmpty) {
                  widget.onAddWorkPlace(newWorkPlace);
                  Navigator.of(context).pop(); // Fermer le popup
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEA2831),
              ),
              child: const Text(
                "Ajouter",
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
    );
  }
}