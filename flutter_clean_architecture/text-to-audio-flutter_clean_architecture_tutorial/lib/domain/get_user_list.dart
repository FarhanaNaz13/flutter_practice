import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/repository/user_repository.dart';

class GetUserListUC {
  final UserRepository _userRepository;

  GetUserListUC(this._userRepository);

  Future<List<User>> call() => _userRepository.getUsers();
}
