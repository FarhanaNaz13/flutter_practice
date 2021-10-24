import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/domain/check_login_state.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._checkLoginStateUC) : super(SessionInitial());
  final CheckLoginStateUC _checkLoginStateUC;

  Future<void> getSession() async {
    emit(SessionLoading());
    try {
      final isLoggedIn = await _checkLoginStateUC();
      emit(SessionSuccess(isLoggedIn));
    } catch (err) {
      emit(SessionFailure());
    }
  }
}
