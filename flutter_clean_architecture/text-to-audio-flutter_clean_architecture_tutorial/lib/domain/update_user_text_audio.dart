import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/data/repository/user_text_audio_repository.dart';

class UpdateUserTextAudio {
  final UserTextAudioRepository _userTextAudioRepository;
  UpdateUserTextAudio(this._userTextAudioRepository);
  Future<void> call(UserTextAudio userTextAudio) =>
      _userTextAudioRepository.updateTextAudio(userTextAudio);
}
