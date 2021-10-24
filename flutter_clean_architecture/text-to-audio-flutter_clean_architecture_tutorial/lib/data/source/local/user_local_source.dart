import 'package:text_to_audio/data/model/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class UserLocalSource {
  Future<List<User>> getUsers();
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(User uesr);
}

class UserLocalSourceImpl implements UserLocalSource {
  final Box<User> _userBox;

  UserLocalSourceImpl(this._userBox);

  @override
  Future<void> createUser(User user) async {
    await _userBox.add(user);
  }

  @override
  Future<void> deleteUser(User uesr) {
    return uesr.delete();
  }

  @override
  Future<List<User>> getUsers() async {
    return _userBox.values.toList();
  }

  @override
  Future<void> updateUser(User user) {
    return user.save();
  }
}
