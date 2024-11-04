import 'dart:developer';

class Note {
  final double rate;
  final String judge;
  final DateTime timestamp;

  Note({
    required this.rate,
    required this.judge,
    required this.timestamp,
  });

  factory Note.fromMap(Map<String, dynamic> data) {
    log("Data : ${data.toString()}");
    return Note(
      rate: double.parse(data['rate'].toString()),
      judge: data['judge'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'judge': judge,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}