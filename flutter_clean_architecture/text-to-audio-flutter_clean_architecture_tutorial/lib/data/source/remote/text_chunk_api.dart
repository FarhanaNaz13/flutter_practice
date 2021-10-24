import 'dart:convert';

import 'package:text_to_audio/data/exception/server_ran_out_of_transcriptions_exception.dart';
import 'package:text_to_audio/data/exception/text_chunk_api_exception.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk_request.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk_response.dart';
import 'package:text_to_audio/data/source/api_header_provider.dart';
import 'package:text_to_audio/utils/api_constatns.dart';
import 'package:http/http.dart' as _http;

abstract class TextChunkApi {
  Future<List<TextChunk>> fetchTextChunk();
}

class TextChunkApiImpl implements TextChunkApi {
  final ApiHeaderProvider _apiHeaderProvider;

  static const _transciption_endpoint = ApiConstants.base_url + '/dataset/v1/transcription/list';

  TextChunkApiImpl(this._apiHeaderProvider);
  @override
  Future<List<TextChunk>> fetchTextChunk() async {
    final headers = await _apiHeaderProvider.getGeneralHeaderMapWithAuth();
    final request = TextChunkRequest('10');
    final response = await _http.post(
      Uri.parse(_transciption_endpoint),
      body: request.toJson(),
      headers: headers,
    );
    // print(response);
    final textChunksResponseBody = utf8.decode(response.bodyBytes);
    
    if (response.statusCode == 200) {
      final list = TextChunkResponse.fromJson(textChunksResponseBody).data;
      if (list.isEmpty)
        throw ServerRanOutOfTranscriptionsException(); // TODO: catch this for future safety
      return list;
    } else {
      throw TextChunkApiException();
    }
  }
}
