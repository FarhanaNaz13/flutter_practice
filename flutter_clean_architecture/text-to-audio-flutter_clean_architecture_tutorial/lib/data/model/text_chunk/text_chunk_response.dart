import 'dart:convert';

import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';

class TextChunkResponse {
  final List<TextChunk> data;

  TextChunkResponse(this.data);

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory TextChunkResponse.fromMap(Map<String, dynamic> map) {
    return TextChunkResponse(
      List<TextChunk>.from(map['data']?.map((x) => TextChunk.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TextChunkResponse.fromJson(String source) => TextChunkResponse.fromMap(json.decode(source));
}
