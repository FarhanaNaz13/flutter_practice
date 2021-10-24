import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/utils/string_res.dart';

class UserWidget extends StatelessWidget {
  final User user;
  const UserWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.raleway(),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(StringRes.age + ': ' + user.age.toString(), style: GoogleFonts.raleway(),),
            SizedBox(width: 8),
            Text(user.gender, style: GoogleFonts.raleway(),)
          ],
        )
      ],
    );
  }
}
