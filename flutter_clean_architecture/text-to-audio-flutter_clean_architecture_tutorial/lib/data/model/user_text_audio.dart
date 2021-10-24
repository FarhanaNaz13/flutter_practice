import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/data/model/user.dart';

part 'user_text_audio.g.dart';

@HiveType(typeId: 13)
class UserTextAudio extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final TextChunk textChunk;
  @HiveField(1)
  Audio audio;
  @HiveField(2)
  bool isReviewd;
  @HiveField(3)
  String environment;

  UserTextAudio({
    required this.textChunk,
    required this.audio,
    this.isReviewd = false,
    required this.environment,
  });

  @override
  List<Object?> get props => [textChunk, audio, environment];

  Map<String, dynamic> toMap() {
    return {
      'textChunk': textChunk.toMap(),
      'audio': audio.toMap(),
      'isReviewd': isReviewd,
      'environment': environment,
    };
  }

  factory UserTextAudio.fromMap(Map<String, dynamic> map) {
    return UserTextAudio(
      textChunk: TextChunk.fromMap(map['textChunk']),
      audio: Audio.fromMap(map['audio']),
      isReviewd: map['isReviewd'],
      environment: map['environment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTextAudio.fromJson(String source) =>
      UserTextAudio.fromMap(json.decode(source));
}
