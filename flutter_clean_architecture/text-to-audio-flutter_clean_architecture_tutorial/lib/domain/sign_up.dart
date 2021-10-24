import 'package:text_to_audio/data/model/signup/signup_request.dart';
import 'package:text_to_audio/data/repository/auth_repository.dart';

class SignUpUC {
  final AuthRepository _authRepository;

  SignUpUC(this._authRepository);

  Future<void> call(SignUpRequest signUpRequest) =>
      _authRepository.signUp(signUpRequest);
}
