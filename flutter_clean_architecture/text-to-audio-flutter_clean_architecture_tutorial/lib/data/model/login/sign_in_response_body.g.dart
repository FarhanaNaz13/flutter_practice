// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response_body.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignInResponseBodyAdapter extends TypeAdapter<SignInResponseBody> {
  @override
  final int typeId = 1;

  @override
  SignInResponseBody read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignInResponseBody(
      loginStatus: fields[0] as String,
      fullName: fields[1] as String,
      email: fields[2] as String,
      mobileNo: fields[3] as String,
      loginId: fields[4] as String,
      insurerId: fields[5] as String,
      userName: fields[6] as String,
      accessJson: fields[7] as String,
      roleDescription: fields[8] as String,
      roleType: fields[9] as String,
      authorizationKey: fields[10] as String,
      loginDateTime: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SignInResponseBody obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.loginStatus)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.mobileNo)
      ..writeByte(4)
      ..write(obj.loginId)
      ..writeByte(5)
      ..write(obj.insurerId)
      ..writeByte(6)
      ..write(obj.userName)
      ..writeByte(7)
      ..write(obj.accessJson)
      ..writeByte(8)
      ..write(obj.roleDescription)
      ..writeByte(9)
      ..write(obj.roleType)
      ..writeByte(10)
      ..write(obj.authorizationKey)
      ..writeByte(11)
      ..write(obj.loginDateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInResponseBodyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
