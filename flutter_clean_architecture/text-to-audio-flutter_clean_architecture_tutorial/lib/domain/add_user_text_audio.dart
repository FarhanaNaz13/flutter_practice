import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/data/repository/audio_repository.dart';
import 'package:text_to_audio/data/repository/user_text_audio_repository.dart';

class AddUserTextAudioUC {
  final UserTextAudioRepository _userTextAudioRepository;
  final AudioRepository _audioRepository;

  AddUserTextAudioUC(
    this._userTextAudioRepository,
    this._audioRepository,
  );

  Future<void> call(String environment, TextChunk textChunk, Audio audio) async {
    await _audioRepository.moveAudioToPermanentFolder(audio);
    print(audio.location);
    return _userTextAudioRepository.addUserTextAudio(
      UserTextAudio(
        textChunk: textChunk,
        environment: environment,
        audio: audio,
      ),
    );
  }
}
