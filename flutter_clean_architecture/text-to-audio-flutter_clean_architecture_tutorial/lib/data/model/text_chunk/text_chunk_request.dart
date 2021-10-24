import 'dart:convert';

class TextChunkRequest {
  final String nTranscriptions;

  TextChunkRequest(this.nTranscriptions);

  Map<String, dynamic> toMap() {
    return {
      'nTranscriptions': nTranscriptions,
    };
  }

  factory TextChunkRequest.fromMap(Map<String, dynamic> map) {
    return TextChunkRequest(
      map['nTranscriptions'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TextChunkRequest.fromJson(String source) =>
      TextChunkRequest.fromMap(json.decode(source));
}
