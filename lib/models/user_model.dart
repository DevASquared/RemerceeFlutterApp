import 'dart:developer';

import 'note_model.dart';

class User {
  String imageUrl;
  List<dynamic> places;
  List<Note> notes;
  final String email;
  final String username;
  final DateTime since;

  User({
    this.imageUrl = "",
    this.places = const [],
    required List<dynamic> dynamicNotes,
    required this.email,
    required this.username,
    required this.since,
  }) : notes = dynamicNotes.map((noteData) => Note.fromMap(noteData)).toList();

  List<double> getNotesSumLast12Months() {
    DateTime now = DateTime.now();
    List<double> notesAvgByMonth = List.filled(12, 0.0);

    Map<String, double> notesSumPerMonth = {};
    Map<String, int> notesCountPerMonth = {};

    // Regrouper les notes par mois
    for (Note note in notes) {
      DateTime noteDate = note.timestamp;
      String monthKey = "${noteDate.year}-${noteDate.month.toString().padLeft(2, '0')}";

      // Ajouter la note à la somme et incrémenter le compteur de notes pour ce mois
      if (notesSumPerMonth.containsKey(monthKey)) {
        notesSumPerMonth[monthKey] = notesSumPerMonth[monthKey]! + note.rate;
        notesCountPerMonth[monthKey] = notesCountPerMonth[monthKey]! + 1;
      } else {
        notesSumPerMonth[monthKey] = note.rate;
        notesCountPerMonth[monthKey] = 1;
      }
    }

    log("Sommes par mois : $notesSumPerMonth");

    // On commence à remplir les moyennes à partir du mois courant
    for (int i = 0; i < 12; i++) {
      DateTime currentMonth = DateTime(now.year, now.month - i, 1);
      String monthKey = "${currentMonth.year}-${currentMonth.month.toString().padLeft(2, '0')}";

      if (notesSumPerMonth.containsKey(monthKey)) {
        // Calculer la moyenne pour ce mois en divisant la somme par le nombre de notes
        double sum = notesSumPerMonth[monthKey]!;
        int count = notesCountPerMonth[monthKey]!;
        notesAvgByMonth[11 - i] = sum / count;
      } else {
        // Si aucune note pour ce mois, utiliser 0
        notesAvgByMonth[11 - i] = 0.0;
      }
    }

    return notesAvgByMonth;
  }
}
