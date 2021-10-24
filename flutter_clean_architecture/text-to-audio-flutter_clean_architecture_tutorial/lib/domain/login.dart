import 'package:text_to_audio/data/repository/auth_repository.dart';

class LoginUC {
  final AuthRepository _authRepository;

  LoginUC(this._authRepository);

  Future<void> call() => _authRepository.login();
}
