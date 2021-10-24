import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_audio/presentation/bloc/auth/auth_cubit.dart';
import 'package:text_to_audio/presentation/bloc/session/session_cubit.dart';
import 'package:text_to_audio/utils/app_route.dart';
import 'package:text_to_audio/utils/string_res.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'John Doe',
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              TextButton(
                child: Text(StringRes.logout),
                onPressed: () async {
                  authCubit.reset();
                  await authCubit.logout();
                  // Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, AppRoute.login_route);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
