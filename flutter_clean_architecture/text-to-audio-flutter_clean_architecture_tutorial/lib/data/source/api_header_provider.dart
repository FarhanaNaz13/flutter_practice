import 'package:text_to_audio/data/source/login_response_source.dart';

abstract class ApiHeaderProvider {
  Future<Map<String, String>> getGeneralHeaderMap();
  Future<Map<String, String>> getGeneralHeaderMapWithAuth();
}

class ApiHeaderProviderImpl implements ApiHeaderProvider {
  final LoginResponseSource _loginResponseSource;
  static Map<String, String> _headerMap =
      Map.from({'Content-Type': 'application/json; charset=utf-8'});

  ApiHeaderProviderImpl(this._loginResponseSource);

  @override
  Future<Map<String, String>> getGeneralHeaderMap() async {
    return _headerMap;
  }

  @override
  Future<Map<String, String>> getGeneralHeaderMapWithAuth() async {
    final loginResponse = await _loginResponseSource.getLoginResponse();
    final Map<String, String> map = Map.from(_headerMap);
    map.addAll({'Authorization': 'Bearer' + ' ' + loginResponse.accessToken});
    return map;
  }
}
