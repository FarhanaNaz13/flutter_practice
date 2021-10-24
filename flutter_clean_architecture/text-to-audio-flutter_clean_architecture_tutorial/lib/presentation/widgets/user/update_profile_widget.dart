import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_audio/presentation/bloc/get_user_to_update/cubit/get_user_to_update_cubit.dart';
import 'package:text_to_audio/presentation/bloc/update_user/cubit/update_user_cubit.dart';
import 'package:text_to_audio/presentation/widgets/user/user_info_form_widget.dart';
import 'package:text_to_audio/utils/string_res.dart';

class UpdateProfileWidget extends StatelessWidget {
  final Function() onUpdateUserSuccess;
  final Function() onCancelPressed;
  const UpdateProfileWidget({
    Key? key,
    required this.onUpdateUserSuccess,
    required this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocBuilder<GetUserToUpdateCubit, GetUserToUpdateState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case GetUserToUpdateError:
            return Text(StringRes.user_not_selected_to_update);
          case GetUserToUpdateSuccess:
            final user = (state as GetUserToUpdateSuccess).user;
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // UserInfoFormWidget(
                  //   formKey: formKey,
                  //   user: user,
                  // ),
                  SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: onCancelPressed,
                            child: Text(StringRes.cancel)),
                        SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          onPressed: () async {
                            final isValid = formKey.currentState?.validate();
                            if (isValid != null && isValid) {
                              await BlocProvider.of<UpdateUserCubit>(context)
                                  .updateUser(user);
                              onUpdateUserSuccess();
                            }
                          },
                          child: Text(StringRes.update),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }
}
