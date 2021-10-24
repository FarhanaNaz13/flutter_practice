import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/domain/update_user.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit(this._updateUser) : super(UpdateUserInitial());
  final UpdateUserUC _updateUser;
  Future<void> updateUser(User user) async {
    emit(UpdateUserLoading());
    try {
      await _updateUser(user);
      emit(UpdateUserSuccess());
    } catch (e) {
      emit(UpdateUserError());
    }
  }
}
