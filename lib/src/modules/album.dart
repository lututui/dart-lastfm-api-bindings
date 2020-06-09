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
    assertEitherOrStrings([artistName, albumName], mbid);

    return AlbumInfo.parse(await _client.buildAndSubmit(
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
    assertEitherOrStrings([artistName, albumName], mbid);

    return TagsList.parse(await _client.buildAndSubmit(
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
    assertEitherOrStrings([artistName, albumName], mbid);

    return TagsList.parse(await _client.buildAndSubmit(
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

    final queryResult = await _client.buildAndSubmit(
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

  Future<bool> addTags(
    String artistName,
    String albumName,
    List<String> tags,
  ) async {
    assert(_client.isAuth);
    assertString(artistName);
    assertString(albumName);
    assert(tags != null && tags.isNotEmpty && tags.length <= 10);
    tags.forEach(assertString);

    return _client.buildAndSubmit('album.addTags', args: {
      'artist': artistName,
      'album': albumName,
      'tags': tags.join(',')
    }).then((value) => value.isEmpty);
  }

  Future<bool> removeTag(
    String artistName,
    String albumName,
    String tagName,
  ) async {
    assert(_client.isAuth);
    assertString(artistName);
    assertString(albumName);
    assertString(tagName);

    return _client.buildAndSubmit('album.removeTag', args: {
      'artist': artistName,
      'album': albumName,
      'tags': tagName,
    }).then((value) => value.isEmpty);
  }
}
