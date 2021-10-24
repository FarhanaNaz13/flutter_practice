import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_to_audio/data/model/user_text_audio.dart';

abstract class UserTextAudioLocalSource {
  Future<List<UserTextAudio>> getUserTextAudios();
  Future<List<UserTextAudio>> getReviewedUserTextAudios();
  Future<void> addUserTextAudio(UserTextAudio textAudio);
  Future<void> deleteUserTextAudio(List<UserTextAudio> textAudios);
  Future<void> updateUserTextAudio(UserTextAudio textAudio);
}

class UserTextAudioLocalSourceImpl implements UserTextAudioLocalSource {
  final Box<UserTextAudio> _userTextAudioBox;

  UserTextAudioLocalSourceImpl(this._userTextAudioBox);
  @override
  Future<void> addUserTextAudio(UserTextAudio textAudio) async {
    await _userTextAudioBox.add(textAudio);
  }

  @override
  Future<void> deleteUserTextAudio(List<UserTextAudio> textAudios) async {
    for (UserTextAudio textAudio in textAudios) {
      await File(textAudio.audio.location).delete();
      await textAudio.delete();
    }
  }

  @override
  Future<List<UserTextAudio>> getReviewedUserTextAudios() async {
    return _userTextAudioBox.values
        .where((element) => element.isReviewd == true)
        .toList();
  }

  @override
  Future<List<UserTextAudio>> getUserTextAudios() async {
    return _userTextAudioBox.values.toList();
  }

  @override
  Future<void> updateUserTextAudio(UserTextAudio textAudio) {
    return textAudio.save();
  }
}
