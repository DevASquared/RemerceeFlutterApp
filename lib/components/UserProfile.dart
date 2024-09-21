import 'dart:developer';

import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String role;
  final String since;

  const UserProfile({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.role,
    required this.since,
  }) : super(key: key);
  @override
  State<UserProfile> createState() => _userProfileState();
}

class _userProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.imageUrl;
    final name = widget.name;
    final role = widget.role;
    final since = widget.since;

    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            role,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Text(
            since,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}