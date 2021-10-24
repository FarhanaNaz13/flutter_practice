import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/data/repository/audio_repository.dart';

class SetCurrentAudioUC {
  final AudioRepository _audioRepository;

  SetCurrentAudioUC(this._audioRepository);

  Future<void> call(Audio audio) =>
      _audioRepository.setCurrentAudio(audio);
}
