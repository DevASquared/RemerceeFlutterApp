import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:remercee/components/user_profile.dart';
import 'package:remercee/pages/edit_page.dart';
import 'package:remercee/utils/api_controller.dart';
import 'package:remercee/utils/constants.dart';

import '../models/user_model.dart';

class ProfilePicture extends StatelessWidget {
  final User user;
  final UserProfile widget;

  const ProfilePicture({
    super.key,
    required this.user,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.14,
        height: MediaQuery.of(context).size.height * 0.14,
        child: Builder(builder: (context) {
          // return Material(
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(500),
          //     onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => EditPage(user: user),
          //       ),
          //     ),
          //   ),
          // ),
          return (user.imageUrl == "")
              ? Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(500),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPage(user: user),
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xFF4D4D4D)),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Hero(
                      tag: "profile_pic",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Image.network(
                          "${ApiController.url}user/image/${user.imageUrl}",
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return const Center(child: CircularProgressIndicator());
                          },
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * 0.035,
                        height: MediaQuery.of(context).size.height * 0.035,
                        child: Material(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(500),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(user: user),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF4D4D4D),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
          // ? widget.public
          //     ? Container()
          //     : const Icon(Icons.edit)
          // : widget.public
          //     ? Image.network(
          //         imageUrl,
          //         errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          //           return const Icon(Icons.broken_image);
          //         },
          //         fit: BoxFit.cover,
          //         width: MediaQuery.of(context).size.height * 0.15,
          //         height: MediaQuery.of(context).size.height * 0.15,
          //         loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          //           if (loadingProgress == null) {
          //             return child;
          //           } else {
          //             return Center(
          //               child: CircularProgressIndicator(
          //                 value: loadingProgress.expectedTotalBytes != null
          //                     ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
          //                     : null,
          //               ),
          //             );
          //           }
          //         },
          //       )
          //     : Image.network(
          //         imageUrl,
          //         errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          //           return const Icon(Icons.broken_image);
          //         },
          //         fit: BoxFit.cover,
          //         width: MediaQuery.of(context).size.height * 0.15,
          //         height: MediaQuery.of(context).size.height * 0.15,
          //         loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          //           if (loadingProgress == null) {
          //             return child;
          //           } else {
          //             return Center(
          //               child: CircularProgressIndicator(
          //                 value: loadingProgress.expectedTotalBytes != null
          //                     ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
          //                     : null,
          //               ),
          //             );
          //           }
          //         },
          //       );
        }),
      ),
    );
  }
}
