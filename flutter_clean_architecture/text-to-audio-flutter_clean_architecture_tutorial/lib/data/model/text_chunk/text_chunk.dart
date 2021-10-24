import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'text_chunk.g.dart';

@HiveType(typeId:12)
class TextChunk extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String oid;
  @HiveField(1)
  final String transcription;

  TextChunk({
    required this.oid,
    required this.transcription,
  });

  @override
  List<Object?> get props => [transcription, oid];

  Map<String, dynamic> toMap() {
    return {
      'oid': oid,
      'transcription': transcription,
    };
  }

  factory TextChunk.fromMap(Map<String, dynamic> map) {
    return TextChunk(
      oid: map['oid'],
      transcription: map['transcription'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TextChunk.fromJson(String source) =>
      TextChunk.fromMap(json.decode(source));
}
