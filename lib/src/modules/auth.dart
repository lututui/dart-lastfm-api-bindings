import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/assert.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/info/session_info.dart';

class LastFM_Auth {
  final LastFM_API_Client _client;

  const LastFM_Auth(this._client) : assert(_client != null);

  Future<SessionInfo> getMobileSession(
    String username,
    String password,
  ) async {
    assertString(username);
    assertString(password);

    return SessionInfo.parse(await _client.buildAndSubmit(
      'auth.getMobileSession',
      rootTag: 'session',
      args: {'username': username, 'password': password},
      forcePost: true,
    ));
  }

  Future<SessionInfo> getSession(String token) async {
    assertString(token);

    return SessionInfo.parse(await _client.buildAndSubmit(
      'auth.getSession',
      rootTag: 'session',
      args: {'token': token},
      forcePost: true,
    ));
  }

  Future<String> getToken() async {
    const methodName = 'auth.getToken';

    final queryResult = await _client.buildAndSubmit(
      methodName,
      forcePost: true,
    );

    ApiException.checkMissingKeys(methodName, ['token'], queryResult);

    return queryResult['token'];
  }

  Uri buildAuthUrl(String token) {
    return Uri.http(
      'www.last.fm',
      '/api/auth/',
      {'api_key': _client.apiKey, 'token': token},
    );
  }
}
