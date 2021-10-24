import 'dart:convert';

class ResetStatusRequest {
  final List<String> transcriptionOids;

  ResetStatusRequest(this.transcriptionOids);

  Map<String, dynamic> toMap() {
    return {
      'transcriptionOids': transcriptionOids,
    };
  }

  factory ResetStatusRequest.fromMap(Map<String, dynamic> map) {
    return ResetStatusRequest(
      List<String>.from(map['transcriptionOids']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetStatusRequest.fromJson(String source) => ResetStatusRequest.fromMap(json.decode(source));
}
