import 'package:text_to_audio/data/repository/auth_repository.dart';

class LogoutUC {
  final AuthRepository _authRepository;

  LogoutUC(this._authRepository);
  Future<void> call() => _authRepository.logout();
}
