import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/utils/string_res.dart';
import 'package:text_to_audio/utils/widget_extentions.dart';

class CreateUserQuickAccessWidget extends StatelessWidget {
  final Function() onAddUserPressed;
  const CreateUserQuickAccessWidget({
    Key? key,
    required this.onAddUserPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddUserPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringRes.previously_created_users,
            style: GoogleFonts.raleway(),
          ),
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.add,
            color: Theme.of(context).primaryColor,
          ).round(context),
        ],
      ),
    );
  }
}
