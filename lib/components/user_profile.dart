import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String place;
  final String since;

  const UserProfile({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.place,
    required this.since,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.imageUrl;
    final name = widget.name;
    final role = widget.place;
    final since = widget.since;

    return SizedBox(
      height: MediaQuery.of(context).size.height / (100 / 25),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const Spacer(),
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            role,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 2),
          Text(
            since,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
