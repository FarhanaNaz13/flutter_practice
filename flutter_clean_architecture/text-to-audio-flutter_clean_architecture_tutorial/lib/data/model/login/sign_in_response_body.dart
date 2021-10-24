import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'sign_in_response_body.g.dart';

@HiveType(typeId: 1)
class SignInResponseBody extends Equatable with HiveObjectMixin{
  SignInResponseBody({
    required this.loginStatus,
    required this.fullName,
    required this.email,
    required this.mobileNo,
    required this.loginId,
    required this.insurerId,
    required this.userName,
    required this.accessJson,
    required this.roleDescription,
    required this.roleType,
    required this.authorizationKey,
    required this.loginDateTime,
  });
  @HiveField(0)
  String loginStatus;
  @HiveField(1)
  String fullName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String mobileNo;
  @HiveField(4)
  String loginId;
  @HiveField(5)
  String insurerId;
  @HiveField(6)
  String userName;
  @HiveField(7)
  String accessJson;
  @HiveField(8)
  String roleDescription;
  @HiveField(9)
  String roleType;
  @HiveField(10)
  String authorizationKey;
  @HiveField(11)
  String loginDateTime;
  factory SignInResponseBody.fromJson(Map<String, dynamic> json) =>
      SignInResponseBody(
        loginStatus: json["loginStatus"],
        fullName: json["fullName"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        loginId: json["loginId"],
        insurerId: json["insurerId"],
        userName: json["userName"],
        accessJson: json["accessJson"],
        roleDescription: json["roleDescription"],
        roleType: json["roleType"],
        authorizationKey: json["authorizationKey"],
        loginDateTime: (json["loginDateTime"]),
      );

  Map<String, dynamic> toJson() => {
    "loginStatus": loginStatus,
    "fullName": fullName,
    "email": email,
    "mobileNo": mobileNo,
    "loginId": loginId,
    "insurerId": insurerId,
    "userName": userName,
    "accessJson": accessJson,
    "roleDescription": roleDescription,
    "roleType": roleType,
    "authorizationKey": authorizationKey,
    "loginDateTime": loginDateTime,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [loginId,loginDateTime,loginStatus,fullName,email,mobileNo,insurerId,userName,accessJson,roleDescription,roleType,authorizationKey];

}
SignInResponseBody signInResponseBodyFromJson(String str) =>
    SignInResponseBody.fromJson(json.decode(str));

String signInSuccessResponseToJson(SignInResponseBody data) => json.encode(data.toJson());
