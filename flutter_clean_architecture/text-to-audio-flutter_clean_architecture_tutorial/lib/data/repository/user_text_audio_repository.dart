import 'package:text_to_audio/data/exception/no_current_user_text_audio_exception.dart';
import 'package:text_to_audio/data/exception/no_internet_exception.dart';
import 'package:text_to_audio/data/model/delete/reset_status_request.dart';
import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/data/network/connection_checker.dart';
import 'package:text_to_audio/data/source/local/user_text_audio_local_source.dart';
import 'package:text_to_audio/data/source/remote/user_text_audio_api.dart';
abstract class UserTextAudioRepository {
  Future<List<UserTextAudio>> getUserTextAudios();
  Future<void> addUserTextAudio(UserTextAudio textAudio);
  Future<void> updateTextAudio(UserTextAudio textAudio);
  Future<void> deleteTextAudios(List<UserTextAudio> textAudios);
  Future<void> sendTextAudiosToServer(List<UserTextAudio> textAudio);
  Future<UserTextAudio> getCurrentUserTextAudio();
  Future<void> setCurrentUserTextAudio(UserTextAudio userTextAudio);
  Future<void> resetStatus(List<UserTextAudio> list);
}

class UserTextAudioRepositoryImpl implements UserTextAudioRepository {
  final UserTextAudioLocalSource _userTextAudioLocalSource;
  final UserTextAudioApi _userTextAudioApi;
  final ConnectionChecker _connectionChecker;
  UserTextAudio? _currentUserTextAudio;

  UserTextAudioRepositoryImpl(
    this._userTextAudioLocalSource,
    this._userTextAudioApi,
    this._connectionChecker,
  );
  @override
  Future<void> addUserTextAudio(UserTextAudio textAudio) {
    return _userTextAudioLocalSource.addUserTextAudio(textAudio);
  }

  @override
  Future<void> deleteTextAudios(List<UserTextAudio> textAudios) async {
    await _userTextAudioLocalSource.deleteUserTextAudio(textAudios);
  }

  @override
  Future<List<UserTextAudio>> getUserTextAudios() {
    return _userTextAudioLocalSource.getUserTextAudios();
  }

  @override
  Future<void> sendTextAudiosToServer(List<UserTextAudio> textAudios) async {
    if (!await _connectionChecker.hasConnection()) throw NoInternetException();
    for (UserTextAudio item in textAudios) {
      try {
        await _userTextAudioApi.sendTextAudio(item);
      } catch (err) {
        print(err);
      }
    }
    await deleteTextAudios(textAudios);
  }

  @override
  Future<void> updateTextAudio(UserTextAudio textAudio) {
    return _userTextAudioLocalSource.updateUserTextAudio(textAudio);
  }

  @override
  Future<UserTextAudio> getCurrentUserTextAudio() async {
    if (_currentUserTextAudio == null) throw NoCurrentUserTextAudioException();
    return _currentUserTextAudio!;
  }

  @override
  Future<void> setCurrentUserTextAudio(UserTextAudio userTextAudio) async {
    _currentUserTextAudio = userTextAudio;
  }

  @override
  Future<void> resetStatus(List<UserTextAudio> textAudios) async {
    if (!await _connectionChecker.hasConnection()) throw NoInternetException();
    await _userTextAudioApi.delete(
        ResetStatusRequest(List.from(textAudios.map((e) => e.textChunk.oid))));
    await deleteTextAudios(textAudios);
  }
}
