import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/model/signup/signup_request.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/domain/create_user.dart';
import 'package:text_to_audio/domain/sign_up.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpUC) : super(SignUpInitial());
  final SignUpUC _signUpUC;

  Future<void> signUp(SignUpRequest signUpRequest) async {
    emit(SignUpLoading());
    try {
      await _signUpUC(signUpRequest);
      emit(SignUpSuccess());
    } catch (_) {
      emit(SignUpFailure());
    }
  }
}
