import 'dart:convert';

class SignUpSuccessResponse {
  final String message;
  final int status;

  SignUpSuccessResponse(this.message, this.status);
  

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'status': status,
    };
  }

  factory SignUpSuccessResponse.fromMap(Map<String, dynamic> map) {
    return SignUpSuccessResponse(
      map['message'],
      map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpSuccessResponse.fromJson(String source) => SignUpSuccessResponse.fromMap(json.decode(source));
}
