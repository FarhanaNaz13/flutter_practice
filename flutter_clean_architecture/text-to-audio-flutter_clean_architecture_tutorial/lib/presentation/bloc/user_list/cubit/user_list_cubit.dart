import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/domain/get_user_list.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit(
    this._getUserListUC,
  ) : super(UserListInitial());
  final GetUserListUC _getUserListUC;
  Future<void> getUserList() async {
    emit(UserListLoading());

    try {
      final List<User> users = await _getUserListUC();
      if (users.isEmpty) {
        emit(UserListEmpty());
      } else {
        emit(UserListLoaded(users));
      }
    } catch (_) {
      emit(UserListError());
    }
  }

  // Future<void> deleteUser(User user) async {
  //   try {
  //     await _deleteUserUC(user);
  //     getUserList();
  //   } catch (_) {}
  // }
}
