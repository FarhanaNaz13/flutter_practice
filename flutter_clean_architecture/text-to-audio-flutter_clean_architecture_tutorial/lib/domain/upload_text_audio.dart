import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/data/repository/user_text_audio_repository.dart';

class UploadTextAudioUC {
  final UserTextAudioRepository _userTextAudioRepository;

  UploadTextAudioUC(this._userTextAudioRepository);

  Future<void> call(List<UserTextAudio> list) =>
      _userTextAudioRepository.sendTextAudiosToServer(list);
}
