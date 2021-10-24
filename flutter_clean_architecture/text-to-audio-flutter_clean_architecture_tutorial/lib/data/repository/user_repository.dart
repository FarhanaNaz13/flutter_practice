import 'package:text_to_audio/data/exception/current_user_not_found_exception.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/source/local/user_local_source.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<void> createUser(User user);
  Future<User> getCurrentUser();
  Future<void> setCurrentUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(User uesr);
  Future<User> getUserToUpdate();
  Future<void> setUserToUpdate(User user);
}

class UserRepositoryImpl implements UserRepository {
  final UserLocalSource _userLocalSource;
  User? _userToUpdate;
  User? _currentUser;

  UserRepositoryImpl(this._userLocalSource);
  @override
  Future<void> createUser(User user) => _userLocalSource.createUser(user);

  @override
  Future<void> deleteUser(User user) {
    if (_currentUser == user) _currentUser = null;
    return _userLocalSource.deleteUser(user);
    
  }

  @override
  Future<User> getCurrentUser() async {
    if (_currentUser == null) throw UserNotFoundException();
    return _currentUser!;
  }

  @override
  Future<List<User>> getUsers() => _userLocalSource.getUsers();
  @override
  Future<void> setCurrentUser(User user) async {
    _currentUser = user;
  }

  @override
  Future<void> updateUser(User user) => _userLocalSource.updateUser(user);

  @override
  Future<User> getUserToUpdate() async {
    if (_userToUpdate == null) throw UserNotFoundException();
    return _userToUpdate!;
  }

  @override
  Future<void> setUserToUpdate(User user) async {
    _userToUpdate = user;
  }
}
