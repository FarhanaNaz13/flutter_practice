import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/data/repository/text_repository.dart';

class SetCurrentTextUC {
  final TextChunkRepository _textRepository;

  SetCurrentTextUC(this._textRepository);
  Future<void> call(TextChunk textChunk) => _textRepository.setCurrentTextChunk(textChunk);
}
