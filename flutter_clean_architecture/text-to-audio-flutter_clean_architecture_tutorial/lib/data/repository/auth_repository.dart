import 'package:text_to_audio/data/exception/no_internet_exception.dart';
import 'package:text_to_audio/data/model/login/login_request.dart';
import 'package:text_to_audio/data/model/signup/signup_request.dart';
import 'package:text_to_audio/data/network/connection_checker.dart';
import 'package:text_to_audio/data/source/login_response_source.dart';
import 'package:text_to_audio/data/source/remote/google_token_source.dart';
import 'package:text_to_audio/data/source/remote/login_api.dart';
import 'package:text_to_audio/data/source/remote/signup_api.dart';

abstract class AuthRepository {
  Future<void> signUp(SignUpRequest signUpRequest);
  Future<void> login();
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<void> clearAuthCache();
}

class AuthRepositoryImpl implements AuthRepository {
  final GoogleLoginSource _googleLoginSource;
  final ConnectionChecker _connectionChecker;
  final LoginApi _loginApi;
  final LoginResponseSource _loginResponseSource;
  final SignUpApi _signUpApi;
  String? _googleAccessToken;
  AuthRepositoryImpl(
    this._googleLoginSource,
    this._connectionChecker,
    this._loginApi,
    this._loginResponseSource,
    this._signUpApi,
  );
  @override
  Future<void> login() async {
    if (!await _connectionChecker.hasConnection()) throw NoInternetException();
    _googleAccessToken = await _googleLoginSource.getToken();
    final loginResponse =
        await _loginApi.login(LoginRequest(_googleAccessToken!));
    await _loginResponseSource.saveLoginResponse(loginResponse);
  }

  @override
  Future<void> logout() async {
    await _googleLoginSource.logout();
    await _loginResponseSource.clearLoginResponse();
  }

  @override
  Future<void> signUp(SignUpRequest signUpRequest) async {
    if (!await _connectionChecker.hasConnection()) throw NoInternetException();
    signUpRequest.token = _googleAccessToken;
    await _signUpApi.signUp(signUpRequest);
  }

  @override
  Future<void> clearAuthCache() async {
    await _googleLoginSource.logout();
    return await _loginResponseSource.clearLoginResponse();
  }

  @override
  Future<bool> isLoggedIn() async {
    await _loginResponseSource
        .getLoginResponse(); //throws exception if no response is cached
    return true;
  }
}
