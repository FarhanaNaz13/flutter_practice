import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/exception/user_does_not_exist_exception.dart';

import 'package:text_to_audio/domain/login.dart';
import 'package:text_to_audio/domain/logout.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._loginUC,
    this._logoutUC,
  ) : super(AuthInitial());

  final LoginUC _loginUC;
  final LogoutUC _logoutUC;

  void reset() {
    emit(AuthInitial());
  }

  Future<void> loginIn() async {
    emit(AuthLoading());
    try {
      await _loginUC();
      emit(AuthSuccess());
    } catch (err) {
      print(err.toString());
      if (err is UserDoesNotExistException)
        emit(AuthFailureUserDoesNotExist());
      else
        emit(AuthFailure());
    }
  }

  Future<void> logout() async {
    await _logoutUC();
  }
}
