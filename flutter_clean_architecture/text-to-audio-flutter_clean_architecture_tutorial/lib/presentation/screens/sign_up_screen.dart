import 'package:flutter/material.dart';
import 'package:text_to_audio/presentation/widgets/user/sign_up_widget.dart';
import 'package:text_to_audio/utils/app_route.dart';
import 'package:text_to_audio/utils/widget_extentions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignUpWidget(
        onCreateUserSuccess: () =>
            Navigator.pushReplacementNamed(context, AppRoute.record_route),
        onCancelPressed: () => Navigator.pop(context)).makethemeScreen(context);
  }
}
