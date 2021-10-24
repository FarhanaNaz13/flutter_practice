import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 10)
class User extends Equatable with HiveObjectMixin{
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  String gender;
  @HiveField(3)
  int dateCreated;
  User({
    required this.name,
    required this.age,
    required this.gender,
    required this.dateCreated,
  });
  @override
  List<Object?> get props => [name, age, gender];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'dateCreated': dateCreated,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      dateCreated: map['dateCreated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
