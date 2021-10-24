// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_chunk.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextChunkAdapter extends TypeAdapter<TextChunk> {
  @override
  final int typeId = 12;

  @override
  TextChunk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextChunk(
      oid: fields[0] as String,
      transcription: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TextChunk obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.oid)
      ..writeByte(1)
      ..write(obj.transcription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextChunkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
