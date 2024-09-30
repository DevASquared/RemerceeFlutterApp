import 'package:flutter/material.dart';

import '../../components/rating_page/ratings_data.dart';
import '../../components/user_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userImageUrl = "";
  late String userName = "";
  late String userPlace = "";
  late String userSince = "";
  double meanRate = 0;
  double rateNumber = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
      child: Column(
        children: <Widget>[
          const UserProfile(
            username: null,
            public: false,
          ),
          const SizedBox(height: 40),
          RatingsData(
            meanRate: meanRate,
            rateNumber: rateNumber,
          ),
        ],
      ),
    );
  }
}
