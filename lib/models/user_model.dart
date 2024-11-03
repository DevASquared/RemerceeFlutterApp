import 'dart:developer';

import 'note_model.dart';

class User {
  String imageUrl;
  List<dynamic> workPlaces;
  List<Note> notes;
  final String email;
  final String username;
  final DateTime since;

  User({
    this.imageUrl = "",
    this.workPlaces = const [],
    required List<dynamic> dynamicNotes,
    required this.email,
    required this.username,
    required this.since,
  }) : notes = dynamicNotes.map((noteData) => Note.fromMap(noteData)).toList();

  User copyWith({
    String? imageUrl,
    List<dynamic>? workPlaces,
    List<Note>? notes,
    String? email,
    String? username,
    DateTime? since,
  }) {
    return User(
      imageUrl: imageUrl ?? this.imageUrl,
      workPlaces: workPlaces ?? List<dynamic>.from(this.workPlaces),
      dynamicNotes: notes?.map((note) => note.toMap()).toList() ?? this.notes.map((note) => note.toMap()).toList(),
      email: email ?? this.email,
      username: username ?? this.username,
      since: since ?? this.since,
    );
  }

  List<double> getNotesSumLast12Months() {
    DateTime now = DateTime.now();
    List<double> notesAvgByMonth = List.filled(12, 0.0);

    Map<String, double> notesSumPerMonth = {};
    Map<String, int> notesCountPerMonth = {};

    for (Note note in notes) {
      DateTime noteDate = note.timestamp;
      String monthKey = "${noteDate.year}-${noteDate.month.toString().padLeft(2, '0')}";

      if (notesSumPerMonth.containsKey(monthKey)) {
        notesSumPerMonth[monthKey] = notesSumPerMonth[monthKey]! + note.rate;
        notesCountPerMonth[monthKey] = notesCountPerMonth[monthKey]! + 1;
      } else {
        notesSumPerMonth[monthKey] = note.rate;
        notesCountPerMonth[monthKey] = 1;
      }
    }

    for (int i = 0; i < 12; i++) {
      DateTime currentMonth = DateTime(now.year, now.month - i, 1);
      String monthKey = "${currentMonth.year}-${currentMonth.month.toString().padLeft(2, '0')}";

      if (notesSumPerMonth.containsKey(monthKey)) {
        double sum = notesSumPerMonth[monthKey]!;
        int count = notesCountPerMonth[monthKey]!;
        notesAvgByMonth[11 - i] = sum / count;
      } else {
        notesAvgByMonth[11 - i] = 0.0;
      }
    }

    return notesAvgByMonth;
  }
}
