import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/repository/user_repository.dart';

class SetCurrentUserUC {
  final UserRepository _userRepository;

  SetCurrentUserUC(this._userRepository);
  Future<void> call(User user) => _userRepository.setCurrentUser(user);
}
