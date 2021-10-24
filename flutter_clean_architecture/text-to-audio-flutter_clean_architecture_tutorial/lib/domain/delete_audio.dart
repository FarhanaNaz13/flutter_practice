import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/data/repository/audio_repository.dart';

class DeleteAudioUC {
  final AudioRepository _audioRepository;
  DeleteAudioUC(this._audioRepository);
  Future<void> call(Audio audio) => _audioRepository.deleteAudio(audio);
}
