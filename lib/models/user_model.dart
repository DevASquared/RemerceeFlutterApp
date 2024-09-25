class User {
  String imageUrl;
  String place;
  // String notes;
  final String email;
  final String username;
  final DateTime since;

  User({
    this.imageUrl = "",
    this.place = "",
    // required this.notes,
    required this.email,
    required this.username,
    required this.since,
  });

}
