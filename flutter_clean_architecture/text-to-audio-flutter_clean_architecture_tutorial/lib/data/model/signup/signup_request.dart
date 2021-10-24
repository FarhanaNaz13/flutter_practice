import 'dart:convert';

class SignUpRequest {
  String? token;
  String name;
  String gender;
  int age;

  SignUpRequest({
    this.token,
    required this.name,
    required this.gender,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'name': name,
      'gender': gender,
      'age': age,
    };
  }

  factory SignUpRequest.fromMap(Map<String, dynamic> map) {
    return SignUpRequest(
      token: map['token'],
      name: map['name'],
      gender: map['gender'],
      age: map['age'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpRequest.fromJson(String source) =>
      SignUpRequest.fromMap(json.decode(source));
}
