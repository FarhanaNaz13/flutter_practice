import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/data/repository/audio_repository.dart';

class GetCurrentAudioUC {
  final AudioRepository _userTextAudioRepository;

  GetCurrentAudioUC(this._userTextAudioRepository);

  Future<Audio> call() =>
      _userTextAudioRepository.getCurrentAudio();
}
