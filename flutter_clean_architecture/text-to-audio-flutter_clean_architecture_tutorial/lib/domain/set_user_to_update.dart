import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/repository/user_repository.dart';

class SetUserToUpateUC {
  final UserRepository _userRepository;

  SetUserToUpateUC(this._userRepository);
  Future<void> call(User user) =>
      _userRepository.setUserToUpdate(user);
}
