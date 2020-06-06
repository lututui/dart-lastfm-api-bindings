import 'package:last_fm_api/last_fm_api.dart';

class SessionInfo {
  final String username;
  final String sessionKey;
  final int subscriber;

  SessionInfo(this.username, this.sessionKey, this.subscriber)
      : assert(username != null && username.isNotEmpty),
        assert(sessionKey != null && sessionKey.isNotEmpty);

  factory SessionInfo.parse(Map<String, dynamic> data) {
    if (data == null) return null;

    return SessionInfo(
      data['name'],
      data['key'],
      parseInt(data['subscriber']),
    );
  }

  @override
  String toString() => 'MobileSession($username)';
}
