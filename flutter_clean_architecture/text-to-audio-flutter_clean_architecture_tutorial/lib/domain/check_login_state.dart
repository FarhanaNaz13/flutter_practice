import 'package:text_to_audio/data/repository/auth_repository.dart';

class CheckLoginStateUC {
  final AuthRepository _authRepository;

  CheckLoginStateUC(this._authRepository);
  Future<bool> call() => _authRepository.isLoggedIn();
}
