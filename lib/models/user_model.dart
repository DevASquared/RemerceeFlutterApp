class User {
  String imageUrl;
  List<String> places;
  // String notes;
  final String email;
  final String username;
  final DateTime since;

  User({
    this.imageUrl = "",
    this.places = const [],
    // required this.notes,
    required this.email,
    required this.username,
    required this.since,
  });

}
