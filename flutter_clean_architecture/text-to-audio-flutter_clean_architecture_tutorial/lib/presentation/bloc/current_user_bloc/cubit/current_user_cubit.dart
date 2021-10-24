import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/domain/get_current_user.dart';
import 'package:text_to_audio/domain/set_current_user.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit(
    this._getCurrentUserUC, this._setCurrentUser,
  ) : super(CurrentuserInitial());

  final GetCurrentUserUC _getCurrentUserUC;
  final SetCurrentUserUC _setCurrentUser;

  Future<void> getCurrentUser() async {
    emit(CurrentUserLoading());
    try {
      final User user = await _getCurrentUserUC();
      emit(CurrentUserLoaded(user));
    } catch (_) {
      emit(CurrentUserNotSelected());
    }
  }

  Future<void> setCurrentUser(User user) async {
    try {
      await _setCurrentUser(user);

    } catch (_) {
    }
  }
}
