import 'package:google_sign_in/google_sign_in.dart';
import 'package:text_to_audio/data/exception/google_account_not_found_exception.dart';
import 'package:text_to_audio/data/exception/null_id_token_exception.dart';
import 'package:http/http.dart' as _http;

abstract class GoogleLoginSource {
  Future<String> getToken();
  Future<void> logout();
}

class GoogleLoginSourceImpl implements GoogleLoginSource {
  final GoogleSignIn _googleSignIn;

  GoogleLoginSourceImpl(this._googleSignIn);
  @override
  Future<String> getToken() async {
    final googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) throw GoogleAccountNotFoundException();
    final accessToken = (await googleAccount.authentication).accessToken;
    if (accessToken == null) throw NullIdTokenException();
    // print(accessToken);
    // final userContent = await _http.get(Uri.parse(
    //     'https://oauth2.googleapis.com/tokeninfo?accessToken=$accessToken'));
    // print(userContent.body);
    // final response = await _http.get(
    //   Uri.parse('https://people.googleapis.com/v1/people/me/connections'
    //       '?requestMask.includeField=person.names'),
    //   headers: await googleAccount.authHeaders,
    // );
    // print(response.body);
    // await _googleSignIn.signOut();
    // throw NullIdTokenException();

    return accessToken;
  }

  @override
  Future<void> logout() => _googleSignIn.signOut();
}
