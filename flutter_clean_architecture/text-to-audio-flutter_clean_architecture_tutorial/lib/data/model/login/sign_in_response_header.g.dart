// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response_header.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignInResponseHeaderAdapter extends TypeAdapter<SignInResponseHeader> {
  @override
  final int typeId = 2;

  @override
  SignInResponseHeader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignInResponseHeader(
      requestId: fields[0] as String,
      requestDateTime: fields[1] as String,
      responseDateTime: fields[2] as String,
      responseCode: fields[3] as String,
      message: fields[4] as String,
      status: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SignInResponseHeader obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.requestId)
      ..writeByte(1)
      ..write(obj.requestDateTime)
      ..writeByte(2)
      ..write(obj.responseDateTime)
      ..writeByte(3)
      ..write(obj.responseCode)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInResponseHeaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
