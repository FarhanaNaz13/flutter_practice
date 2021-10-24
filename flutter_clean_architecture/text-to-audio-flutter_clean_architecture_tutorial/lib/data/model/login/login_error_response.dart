import 'dart:convert';

class LoginErrorResponse {
  final String message;
  final String error;
  final int status;

  LoginErrorResponse(this.message, this.error, this.status);

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'error': error,
      'status': status,
    };
  }

  factory LoginErrorResponse.fromMap(Map<String, dynamic> map) {
    return LoginErrorResponse(
      map['message'],
      map['error'],
      map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginErrorResponse.fromJson(String source) => LoginErrorResponse.fromMap(json.decode(source));
}
