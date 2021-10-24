import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'sign_in_response_header.g.dart';
@HiveType(typeId: 2)
class SignInResponseHeader extends Equatable with HiveObjectMixin  {
  SignInResponseHeader({
    required this.requestId,
    required this.requestDateTime,
    required this.responseDateTime,
    required this.responseCode,
    required this.message,
    required this.status,
  });
  @HiveField(0)
  String requestId;
  @HiveField(1)
  String requestDateTime;
  @HiveField(2)
  String responseDateTime;
  @HiveField(3)
  String responseCode;
  @HiveField(4)
  String message;
  @HiveField(5)
  String status;

  factory SignInResponseHeader.fromJson(Map<String, dynamic> json) =>
      SignInResponseHeader(
        requestId: json["requestId"],
        requestDateTime: json["requestDateTime"],
        responseDateTime: (json["responseDateTime"]),
        responseCode: json["responseCode"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "requestDateTime": requestDateTime,
    "responseDateTime": responseDateTime,
    "responseCode": responseCode,
    "message": message,
    "status": status,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [requestId,requestDateTime,requestDateTime,responseCode,message,status];

}
SignInResponseHeader signInResponseHeaderFromJson(String str) =>
    SignInResponseHeader.fromJson(json.decode(str));

String signInResponseHeaderToJson(SignInResponseHeader data) => json.encode(data.toJson());