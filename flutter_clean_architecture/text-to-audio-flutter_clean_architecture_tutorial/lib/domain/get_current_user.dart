import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/repository/user_repository.dart';

class GetCurrentUserUC {
  final UserRepository _userRepository;

  GetCurrentUserUC(this._userRepository);

  Future<User> call() => _userRepository.getCurrentUser();
}
