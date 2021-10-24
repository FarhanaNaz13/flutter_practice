import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/model/login/sign_in_response_body.dart';
import 'package:text_to_audio/data/model/login/sign_in_response_header.dart';
part 'sign_in_success_response.g.dart';


@HiveType(typeId: 0)
class SignInSuccessResponse extends Equatable with HiveObjectMixin  {
  SignInSuccessResponse({
    required this.header,
    required this.body,
  });
  @HiveField(0)
  SignInResponseHeader header;
  @HiveField(1)
  SignInResponseBody body;
  factory SignInSuccessResponse.fromJson(Map<String, dynamic> json) => SignInSuccessResponse(
    header: SignInResponseHeader.fromJson(json["header"]),
    body: SignInResponseBody.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "header": header.toJson(),
    "body": body.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [header,body];


}

SignInSuccessResponse signInSuccessResponseFromJson(String str) =>
    SignInSuccessResponse.fromJson(json.decode(str));

String signInSuccessResponseToJson(SignInSuccessResponse data) => json.encode(data.toJson());

