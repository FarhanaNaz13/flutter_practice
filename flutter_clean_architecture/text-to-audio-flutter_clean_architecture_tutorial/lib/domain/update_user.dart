import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/repository/user_repository.dart';

class UpdateUserUC {
  final UserRepository _userRepository;

  UpdateUserUC(this._userRepository);
  Future<void> call(User user) => _userRepository.updateUser(user);
}
