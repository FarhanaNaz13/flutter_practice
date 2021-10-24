import 'package:text_to_audio/data/repository/audio_repository.dart';

class GetNewAudioPathUC {
  final AudioRepository _audioRepository;
  GetNewAudioPathUC(this._audioRepository);
  Future<String> call() => _audioRepository.getNewAudioPath();
}
