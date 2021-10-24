import 'package:text_to_audio/data/exception/no_internet_exception.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/data/network/connection_checker.dart';
import 'package:text_to_audio/data/source/local/text_chunk_local_source.dart';
import 'package:text_to_audio/data/source/remote/text_chunk_api.dart';

abstract class TextChunkRepository {
  Future<TextChunk> getCurrentTextChunk();
  Future<void> setCurrentTextChunk(TextChunk textChunk);
  Future<TextChunk> getNewTextChunk();
}

class TextRepositoryImpl implements TextChunkRepository {
  TextChunk? _currentTextChunk;
  final TextChunkLocalSource _textChunkLocalSource;
  final TextChunkApi _textChunkApi;
  final ConnectionChecker _connectionChecker;
  List<TextChunk> _textChunkList = [];

  TextRepositoryImpl(
    this._textChunkLocalSource,
    this._textChunkApi,
    this._connectionChecker,
  );
  @override
  Future<TextChunk> getCurrentTextChunk() async {
    if (_currentTextChunk == null) _currentTextChunk = await getNewTextChunk();
    return _currentTextChunk!;
  }

  Future<void> _getTexts() async {
    if (!await _connectionChecker.hasConnection()) throw NoInternetException();
    final fetched = await _textChunkApi.fetchTextChunk();
    await _textChunkLocalSource.saveTexts(fetched);
  }

  @override
  Future<void> setCurrentTextChunk(TextChunk textChunk) async {
    _currentTextChunk = textChunk;
  }

  @override
  Future<TextChunk> getNewTextChunk() async {
    try {
      if (_currentTextChunk != null) {
        await _currentTextChunk!.delete();
        _textChunkList.remove(_currentTextChunk);
      }
    } catch (e) {}

    if (_textChunkList.isEmpty) {
      _textChunkList.addAll(await _textChunkLocalSource.getTexts());
      if (_textChunkList.isEmpty) await _getTexts();
      return getNewTextChunk();
    } else
      return _textChunkList[0];
  }
}
