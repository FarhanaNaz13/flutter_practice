import 'package:hive/hive.dart';
import 'package:text_to_audio/data/exception/null_login_response_exception.dart';
import 'package:text_to_audio/data/model/login/login_success_response.dart';

abstract class LoginResponseSource {
  Future<LoginSuccessResponse> getLoginResponse();
  Future<void> saveLoginResponse(LoginSuccessResponse response);
  Future<void> clearLoginResponse();
}

class LoginResponseSourceImpl implements LoginResponseSource {
  final Box<LoginSuccessResponse> _loginSuccessResponseBox;

  LoginResponseSourceImpl(this._loginSuccessResponseBox);
  @override
  Future<void> clearLoginResponse() async {
    await _loginSuccessResponseBox.clear();
  }

  @override
  Future<LoginSuccessResponse> getLoginResponse() async {
    final response = _loginSuccessResponseBox.getAt(0);
    if (response == null) throw NulLoginResponseException();
    return response;
  }

  @override
  Future<void> saveLoginResponse(LoginSuccessResponse response) async {
    await _loginSuccessResponseBox.clear();
    await _loginSuccessResponseBox.add(response);
  }
}
