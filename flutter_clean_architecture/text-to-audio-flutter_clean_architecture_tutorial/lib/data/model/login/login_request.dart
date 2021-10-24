import 'dart:convert';

class LoginRequest {
  final String token;

  LoginRequest(this.token);


  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) => LoginRequest.fromMap(json.decode(source));
}
