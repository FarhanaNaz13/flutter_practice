import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_audio/presentation/bloc/current_user_bloc/cubit/current_user_cubit.dart';
import 'package:text_to_audio/presentation/widgets/selector_widget.dart';
import 'package:text_to_audio/presentation/widgets/user/user_function_widget.dart';
import 'package:text_to_audio/utils/app_route.dart';
import 'package:text_to_audio/utils/string_res.dart';

class CurrentUserWidget extends StatelessWidget {
  const CurrentUserWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, CurrentUserState state) {
        switch (state.runtimeType) {
          case CurrentUserLoading:
            return CircularProgressIndicator();
          case CurrentUserLoaded:
            return UserFunctionWidget(
              user: (state as CurrentUserLoaded).currentUser,
              // onChangePressed: () {
              //   Navigator.pushNamed(context, AppRoute.userInfoRoute);
              // },
              // onEditPressed: () {},
            );
          default:
            return SelectorWiget(
                text: StringRes.select_profile,
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.user_info_route);
                });
        }
      },
    );
  }
}
