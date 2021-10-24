import 'package:text_to_audio/data/repository/audio_repository.dart';

class ClearCurrentAudioUC {
  final AudioRepository _audioRepository;

  ClearCurrentAudioUC(this._audioRepository);

  Future<void> call() => _audioRepository.clearCurrentAudio();
}
