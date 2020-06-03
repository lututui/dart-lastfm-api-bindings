import 'package:last_fm_api/src/api_client.dart';

import 'file:///C:/Users/LuizArthurChagasOliv/Documents/GitHub/last_fm_api/lib/src/info/album_info.dart';

class LastFM_Album {
  final LastFM_API_Client _client;

  const LastFM_Album(this._client);

  /// Requires auth
  Future addTags(String artistName, String albumName, List<String> tags) {
    throw UnimplementedError();
  }

  Future<AlbumInfo> getInfo(String artistName, String albumName,
      {String mbid,
      bool autocorrect,
      String usernamePlayCount,
      String lang}) async {
    assert((artistName != null && albumName != null) || mbid != null);

    return AlbumInfo.parse(await _client.buildAndGet(
      'album.getInfo',
      'album',
      {
        'artist': artistName,
        'album': albumName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0',
        'username': usernamePlayCount,
        'lang': lang,
      },
    ));
  }

  Future getTags(
    String artistName,
    String albumName, [
    String mbid,
    bool autocorrect,
    String usernamePlayCount,
  ]) {
    throw UnimplementedError();
  }

  Future getTopTags(
    String artistName,
    String albumName, [
    String mbid,
    bool autocorrect,
  ]) {
    throw UnimplementedError();
  }

  /// Auth required
  Future removeTag(String artistName, String albumName, String tagName) {
    throw UnimplementedError();
  }

  Future search(String albumName, [int limit, int page]) {
    throw UnimplementedError();
  }
}
