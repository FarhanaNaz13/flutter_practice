import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/repository/user_repository.dart';

class DeleteUserUC {
  final UserRepository _userRepository;

  DeleteUserUC(this._userRepository);

  Future<void> call(User user) => _userRepository.deleteUser(user);
}
