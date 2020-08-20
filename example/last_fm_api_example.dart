import 'package:last_fm_api/last_fm_api.dart';

void main(List<String> args) async {
  final lastfm = LastFM_API(
    'fbced214c572055d7fba94136e59501b',
    apiSecret: '0be48b984bb615c4701fdb31b0314fb2',
  );

  lastfm.sessionKey = '9k9_Qma1-BoMkJrlDSLk9nMXW2OgKK_X';
}
