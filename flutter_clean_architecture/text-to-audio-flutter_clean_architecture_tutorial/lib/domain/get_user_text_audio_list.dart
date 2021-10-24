import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/data/repository/user_text_audio_repository.dart';

class GetUserTextAudioListUC {
  final UserTextAudioRepository _userTextAudioRepository;

  GetUserTextAudioListUC(this._userTextAudioRepository);

  Future<List<UserTextAudio>> call() =>
      _userTextAudioRepository.getUserTextAudios();
}
