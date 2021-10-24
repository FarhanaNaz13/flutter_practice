import 'package:text_to_audio/data/exception/login_exception.dart';
import 'package:text_to_audio/data/exception/user_does_not_exist_exception.dart';
import 'package:text_to_audio/data/model/login/login_request.dart';
import 'package:text_to_audio/data/model/login/login_success_response.dart';
import 'package:http/http.dart' as _http;
import 'package:text_to_audio/data/source/api_header_provider.dart';
import 'package:text_to_audio/utils/api_constatns.dart';

abstract class LoginApi {
  Future<LoginSuccessResponse> login(LoginRequest loginRequest);
}

class LoginApiImpl implements LoginApi {
  final ApiHeaderProvider _apiHeaderProvider;
  static const _login_end_point = ApiConstants.base_url + '/user/v1/login';

  LoginApiImpl(this._apiHeaderProvider);
  @override
  Future<LoginSuccessResponse> login(LoginRequest loginRequest) async {
    final headers =  await _apiHeaderProvider.getGeneralHeaderMap();
    final response = await _http.post(Uri.parse(_login_end_point),
        body: loginRequest.toJson(), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201)
      return LoginSuccessResponse.fromJson(response.body);
    else if (response.statusCode == 404)
      throw UserDoesNotExistException();
    else {
      print(response.body);
      throw LoginException();
    }
  }
}
