import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/repository/user_repository.dart';

class CreateUserUC {
  final UserRepository _userRepository;

  CreateUserUC(this._userRepository);

  Future<void> call(User user) =>
    _userRepository.createUser(user);
  
}
