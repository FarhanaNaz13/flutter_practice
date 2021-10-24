import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'audio.g.dart';

@HiveType(typeId: 11)
class Audio extends Equatable with HiveObjectMixin{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int duration;
  @HiveField(2)
  final int fileSize;
  @HiveField(3)
  final int dateCreated;
  @HiveField(4)
  String location;
  Audio({
    required this.name,
    required this.duration,
    required this.fileSize,
    required this.dateCreated,
    required this.location,
  });

  @override
  List<Object?> get props => [name, duration, fileSize, dateCreated, location];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'fileSize': fileSize,
      'dateCreated': dateCreated,
      'location': location,
    };
  }

  factory Audio.fromMap(Map<String, dynamic> map) {
    return Audio(
      name: map['name'],
      duration: map['duration'],
      fileSize: map['fileSize'],
      dateCreated: map['dateCreated'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Audio.fromJson(String source) => Audio.fromMap(json.decode(source));
}
