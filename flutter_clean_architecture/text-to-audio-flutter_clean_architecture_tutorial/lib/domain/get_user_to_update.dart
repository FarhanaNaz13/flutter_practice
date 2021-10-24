import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/repository/user_repository.dart';

class GetUserToUpdateUC {
  final UserRepository _userRepository;

  GetUserToUpdateUC(this._userRepository);
  Future<User> call() => _userRepository.getUserToUpdate();
}
