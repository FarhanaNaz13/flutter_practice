import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/domain/set_user_to_update.dart';

part 'set_user_to_update_state.dart';

class SetUserToUpdateCubit extends Cubit<SetUserToUpdateState> {
  SetUserToUpdateCubit(this._setUserToUpate) : super(SetUserToUpdateInitial());
  final SetUserToUpateUC _setUserToUpate;
  Future<void> setUser(User user) async {
    emit(SetUserToUpdateLoading());
    try {
      await _setUserToUpate(user);
      emit(SetUserToUpdateSuccess());
    } catch (_) {
      emit(SetUserToUpdateError());
    }
  }
}
