// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_success_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignInSuccessResponseAdapter extends TypeAdapter<SignInSuccessResponse> {
  @override
  final int typeId = 0;

  @override
  SignInSuccessResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignInSuccessResponse(
      header: fields[0] as SignInResponseHeader,
      body: fields[1] as SignInResponseBody,
    );
  }

  @override
  void write(BinaryWriter writer, SignInSuccessResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.header)
      ..writeByte(1)
      ..write(obj.body);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInSuccessResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
