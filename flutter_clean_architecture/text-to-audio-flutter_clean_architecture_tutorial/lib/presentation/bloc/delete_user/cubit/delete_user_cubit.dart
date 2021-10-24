import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/model/user.dart';

import 'package:text_to_audio/domain/delete_user.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit(
    this._deleteUserUC,
  ) : super(DeleteUserInitial());
  final DeleteUserUC _deleteUserUC;
  Future<void> delete(User user) async {
    emit(DeleteUserLoading());
    try {
      await _deleteUserUC(user);
      emit(DeleteUserSuccess());
    } catch (_) {
      emit(DeleteUserError());
    }
  }
}
