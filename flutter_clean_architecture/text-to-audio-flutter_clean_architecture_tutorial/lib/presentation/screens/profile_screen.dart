import 'package:flutter/material.dart';
import 'package:text_to_audio/presentation/widgets/user/user_widgets_holder.dart';
import 'package:text_to_audio/utils/widget_extentions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: UserWidgetsHolderWidget()))
        .makethemeScreen(context);
  }
}
