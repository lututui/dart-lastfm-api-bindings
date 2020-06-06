import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/assert.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/info/album_info.dart';
import 'package:last_fm_api/src/lists/albums_list.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';

class LastFM_Album {
  final LastFM_API_Client _client;

  const LastFM_Album(this._client) : assert(_client != null);

  Future<AlbumInfo> getInfo({
    String artistName,
    String albumName,
    String mbid,
    bool autocorrect,
    String usernamePlayCount,
    String lang,
  }) async {
    assertOptionalStrings([artistName, albumName], mbid);

    return AlbumInfo.parse(await _client.buildAndGet(
      'album.getInfo',
      rootTag: 'album',
      args: {
        'artist': artistName,
        'album': albumName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0',
        'username': usernamePlayCount,
        'lang': lang,
      },
    ));
  }

  Future<TagsList> getTags(
    String user, {
    String artistName,
    String albumName,
    String mbid,
    bool autocorrect,
  }) async {
    assertString(user);
    assertOptionalStrings([artistName, albumName], mbid);

    return TagsList.parse(await _client.buildAndGet(
      'album.getTags',
      rootTag: 'tags',
      args: {
        'artist': artistName,
        'album': albumName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0',
        'user': user,
      },
    ));
  }

  Future<TagsList> getTopTags({
    String artistName,
    String albumName,
    String mbid,
    bool autocorrect,
  }) async {
    assertOptionalStrings([artistName, albumName], mbid);

    return TagsList.parse(await _client.buildAndGet(
      'album.getTopTags',
      rootTag: 'topTags',
      args: {
        'artist': artistName,
        'album': albumName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0',
      },
    ));
  }

  Future<AlbumsList> search(String albumName, {int limit, int page}) async {
    assertString(albumName);
    assertOptionalPositive(limit);
    assertOptionalPositive(page);

    const methodName = 'album.search';

    final queryResult = await _client.buildAndGet(
      methodName,
      rootTag: 'results',
      args: {
        'album': albumName,
        'limit': limit?.toString(),
        'page': page?.toString(),
      },
    );

    ApiException.checkMissingKeys(methodName, ['albummatches'], queryResult);

    return AlbumsList.parse({
      ...queryResult['albummatches'],
      '@attr': buildSearchAttr(methodName, queryResult),
    });
  }

  // TODO: Requires auth
  Future addTags(String artistName, String albumName, List<String> tags) {
    throw UnimplementedError();
  }

  // TODO: Auth required
  Future removeTag(String artistName, String albumName, String tagName) {
    throw UnimplementedError();
  }
}
