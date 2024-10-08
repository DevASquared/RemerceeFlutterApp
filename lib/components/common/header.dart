import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class Header extends StatelessWidget {
  final void Function() logout;
  final void Function() showQrCode;
  final FToast fToast;

  const Header({
    Key? key,
    required this.logout,
    required this.showQrCode,
    required this.fToast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 11.5,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: IconButton(
              onPressed: () async {
                if (await Constants.isConnected()) {
                  showQrCode();
                } else {
                  Constants.showNotConnectedToast(fToast, "Vous n'êtes pas connecté !");
                }
              },
              icon: const Icon(Icons.qr_code_2_rounded),
            ),
          ),
          Text(
            "REMERCEE",
            style: GoogleFonts.inter(
              fontSize: 24,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: IconButton(
              onPressed: () {
                Constants.getPreferences().then(
                  (value) {
                    value.setBool("connected", false);
                    value.remove("username");
                    logout();
                  },
                );
              },
              icon: const Icon(Icons.output_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
