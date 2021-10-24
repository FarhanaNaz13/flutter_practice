import 'package:text_to_audio/data/exception/sign_up_exception.dart';
import 'package:text_to_audio/data/model/signup/signup_request.dart';
import 'package:text_to_audio/data/model/signup/signup_success_response.dart';
import 'package:http/http.dart' as _http;
import 'package:text_to_audio/data/source/api_header_provider.dart';
import 'package:text_to_audio/utils/api_constatns.dart';

abstract class SignUpApi {
  Future<SignUpSuccessResponse> signUp(SignUpRequest signUpRequest);
}

class SignUpApiImpl implements SignUpApi {
  static const _signup_endpoint = ApiConstants.base_url + '/user/v1/signup';
  final ApiHeaderProvider _apiHeaderProvider;

  SignUpApiImpl(this._apiHeaderProvider);
  @override
  Future<SignUpSuccessResponse> signUp(SignUpRequest signUpRequest) async {
    final headers = await _apiHeaderProvider.getGeneralHeaderMap();
    final response = await _http.post(Uri.parse(_signup_endpoint),
        body: signUpRequest.toJson(), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return SignUpSuccessResponse.fromJson(response.body);
    }
    throw SignUpException();
  }
}
