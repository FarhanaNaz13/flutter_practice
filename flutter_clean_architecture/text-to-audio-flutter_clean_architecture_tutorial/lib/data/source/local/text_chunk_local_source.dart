import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';

abstract class TextChunkLocalSource {
  Future<List<TextChunk>> getTexts();
  Future<void> saveTexts(List<TextChunk> textChunks);
}

class TextChunkLocalSourceImpl implements TextChunkLocalSource {
  final Box<TextChunk> _textChunkBox;

  TextChunkLocalSourceImpl(this._textChunkBox);
  @override
  Future<List<TextChunk>> getTexts() async {
    return _textChunkBox.values.toList();
  }

  @override
  Future<void> saveTexts(List<TextChunk> textChunks) async {
    await _textChunkBox.addAll(textChunks);
  }
}
