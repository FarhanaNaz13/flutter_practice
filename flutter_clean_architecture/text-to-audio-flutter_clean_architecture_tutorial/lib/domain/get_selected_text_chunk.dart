
import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/data/repository/text_repository.dart';

class GetSelectedTextChunkUC {
  final TextChunkRepository _textRepository;

  GetSelectedTextChunkUC(this._textRepository);

  Future<TextChunk> call() => _textRepository.getCurrentTextChunk();
}
