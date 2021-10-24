import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/data/repository/user_text_audio_repository.dart';

class DeleteUserTextAudioResetStatusUC {
  final UserTextAudioRepository _userTextAudioRepository;

  DeleteUserTextAudioResetStatusUC(this._userTextAudioRepository);

  Future<void> call(List<UserTextAudio> userTextAudios) => _userTextAudioRepository.resetStatus(userTextAudios);
}
