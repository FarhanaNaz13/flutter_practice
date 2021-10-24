// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_text_audio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTextAudioAdapter extends TypeAdapter<UserTextAudio> {
  @override
  final int typeId = 13;

  @override
  UserTextAudio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTextAudio(
      textChunk: fields[0] as TextChunk,
      audio: fields[1] as Audio,
      isReviewd: fields[2] as bool,
      environment: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserTextAudio obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.textChunk)
      ..writeByte(1)
      ..write(obj.audio)
      ..writeByte(2)
      ..write(obj.isReviewd)
      ..writeByte(3)
      ..write(obj.environment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTextAudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
