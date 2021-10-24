import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_audio/presentation/bloc/auth/auth_cubit.dart';
import 'package:text_to_audio/presentation/bloc/session/session_cubit.dart';
import 'package:text_to_audio/utils/app_route.dart';
import 'package:text_to_audio/utils/string_res.dart';
import 'package:text_to_audio/utils/widget_extentions.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionCubit, SessionState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SessionSuccess:
            final isLoggedIn = (state as SessionSuccess).isUserLoggedIn;
            if (isLoggedIn)
              Navigator.pushReplacementNamed(context, AppRoute.record_route);
            else
              Navigator.pushReplacementNamed(context, AppRoute.login_route);
            break;
          case SessionFailure:
            Navigator.pushReplacementNamed(context, AppRoute.login_route);
            break;
        }
      },
      builder: (context, state) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ).makethemeScreen(context);
  }
}
