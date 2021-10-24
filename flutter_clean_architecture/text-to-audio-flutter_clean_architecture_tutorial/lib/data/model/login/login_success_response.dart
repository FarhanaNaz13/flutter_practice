import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'login_success_response.g.dart';

@HiveType(typeId: 4)
class LoginSuccessResponse extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String gender;

  LoginSuccessResponse(
    this.accessToken,
    this.name,
    this.email,
    this.gender,
  );

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'name': name,
      'email': email,
      'gender': gender,
    };
  }

  factory LoginSuccessResponse.fromMap(Map<String, dynamic> map) {
    return LoginSuccessResponse(
      map['accessToken'],
      map['name'],
      map['email'],
      map['gender'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginSuccessResponse.fromJson(String source) =>
      LoginSuccessResponse.fromMap(json.decode(source));

  @override
  List<Object?> get props => [accessToken];
}
