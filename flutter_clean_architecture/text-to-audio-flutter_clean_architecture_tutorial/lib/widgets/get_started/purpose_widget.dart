import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/utils/string_res.dart';

class PurposeWidget extends StatelessWidget {
  const PurposeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringRes.welcome,
            style: GoogleFonts.raleway(
              fontSize: 44,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            StringRes.purpose,
            style: GoogleFonts.raleway(fontSize: 16),
          )
        ],
      ),
    );
  }
}
