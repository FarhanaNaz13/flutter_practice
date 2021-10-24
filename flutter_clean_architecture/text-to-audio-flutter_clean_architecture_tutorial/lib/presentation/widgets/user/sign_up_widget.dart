import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_audio/data/model/signup/signup_request.dart';
import 'package:text_to_audio/presentation/bloc/sign_up_bloc/sign_up_cubit.dart';
import 'package:text_to_audio/presentation/widgets/user/user_info_form_widget.dart';
import 'package:text_to_audio/utils/string_res.dart';

class SignUpWidget extends StatelessWidget {
  final Function() onCreateUserSuccess;
  final Function() onCancelPressed;
  const SignUpWidget({
    Key? key,
    required this.onCreateUserSuccess,
    required this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final user = SignUpRequest(
      age: 0,
      name: '',
      gender: ''
    ); //This is an invalid instance of user && will be validated later
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserInfoFormWidget(
                  formKey: formKey,
                  user: user,
                ),
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
                            await BlocProvider.of<SignUpCubit>(context)
                                .signUp(user);
                            onCreateUserSuccess();
                          }
                        },
                        child: Text(StringRes.sign_up),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
