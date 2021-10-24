import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_audio/presentation/bloc/current_user_bloc/cubit/current_user_cubit.dart';
import 'package:text_to_audio/presentation/bloc/delete_user/cubit/delete_user_cubit.dart';
import 'package:text_to_audio/presentation/bloc/set_user_to_update/cubit/set_user_to_update_cubit.dart';
import 'package:text_to_audio/presentation/bloc/user_list/cubit/user_list_cubit.dart';
import 'package:text_to_audio/presentation/widgets/user/user_function_widget.dart';
import 'package:text_to_audio/utils/string_res.dart';

class UserListWidget extends StatelessWidget {
  final Function()? onUpdateUserPressed;
  final Function()? onUserTapped;
  const UserListWidget({
    Key? key,
    this.onUpdateUserPressed,
    this.onUserTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListCubit, UserListState>(
        builder: (cxt, UserListState state) {
      switch (state.runtimeType) {
        case UserListLoaded:
          final list = (state as UserListLoaded).userList.reversed.toList();
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await BlocProvider.of<CurrentUserCubit>(context)
                      .setCurrentUser(list[index]);

                  await BlocProvider.of<CurrentUserCubit>(context)
                      .getCurrentUser();

                  onUserTapped?.call();
                },
                child: UserFunctionWidget(
                  user: list[index],
                  onDeletePressed: () async {
                    await BlocProvider.of<DeleteUserCubit>(context)
                        .delete(list[index]);
                    BlocProvider.of<UserListCubit>(context).getUserList();
                  },
                  onEditPressed: () async {
                    await BlocProvider.of<SetUserToUpdateCubit>(context)
                        .setUser(list[index]);
                    onUpdateUserPressed?.call();
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: list.length,
          );
        case UserListLoading:
          return Center(
            child: CircularProgressIndicator(),
          );
        case UserListError:
          return Center(child: Text(StringRes.something_went_wrong));
        default:
          return Text(StringRes.no_user_has_been_created_yet);
      }
    });
  }
}
