import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_audio/presentation/bloc/auth/auth_cubit.dart';
import 'package:text_to_audio/presentation/bloc/session/session_cubit.dart';
import 'package:text_to_audio/utils/app_route.dart';
import 'package:text_to_audio/utils/string_res.dart';
import 'package:text_to_audio/utils/widget_extentions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionCubit = BlocProvider.of<SessionCubit>(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case AuthFailureUserDoesNotExist:
            Navigator.pushNamed(context, AppRoute.sign_up_route);
            break;
          case AuthSuccess:
            Navigator.pushReplacementNamed(context, AppRoute.record_route);
            break;
        }
      },
      builder: (context, state) {
       
        switch (state.runtimeType) {
          case AuthLoading:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Center(
              child: ElevatedButton(
                child: Text(StringRes.login_with_google),
                onPressed: () async {
                  await authCubit.logout();
                  await authCubit.loginIn();
                },
              ),
            );
        }
      },
    ).makethemeScreen(context);
  }
}
