import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/assert.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/info/artist_info.dart';
import 'package:last_fm_api/src/lists/albums_list.dart';
import 'package:last_fm_api/src/lists/artists_list.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';

class LastFM_Artist {
  final LastFM_API_Client _client;

  const LastFM_Artist(this._client) : assert(_client != null);

  Future<ArtistInfo> getCorrection(String artistName) async {
    assertString(artistName);

    const methodName = 'artist.getCorrection';

    final queryResult = await _client.buildAndSubmit(
      methodName,
      rootTag: 'corrections',
      args: {'artist': artistName},
    );

    ApiException.checkMissingKeys(methodName, ['correction'], queryResult);
    ApiException.checkMissingKeys(
      methodName,
      ['artist'],
      queryResult['correction'],
    );

    return ArtistInfo.parse(queryResult['correction']['artist']);
  }

  Future<ArtistInfo> getInfo({
    String artistName,
    String mbid,
    String lang,
    bool autocorrect,
    String usernamePlayCount,
  }) async {
    assertEitherOrStrings([artistName], mbid);

    return ArtistInfo.parse(await _client.buildAndSubmit(
      'artist.getInfo',
      rootTag: 'artist',
      args: {
        'artist': artistName,
        'mbid': mbid,
        'lang': lang,
        'autocorrect': autocorrect ?? false ? '1' : '0',
        'username': usernamePlayCount,
      },
    ));
  }

  Future<ArtistsList> getSimilar({
    String artistName,
    String mbid,
    int limit,
    bool autocorrect,
  }) async {
    assertEitherOrStrings([artistName], mbid);
    assertOptionalPositive(limit);

    return ArtistsList.parse(await _client.buildAndSubmit(
      'artist.getSimilar',
      rootTag: 'similarArtists',
      args: {
        'artist': artistName,
        'mbid': mbid,
        'limit': limit?.toString(),
        'autocorrect': autocorrect ?? false ? '1' : '0'
      },
    ));
  }

  Future<TagsList> getTags(
    String username, {
    String artistName,
    String mbid,
    bool autocorrect,
  }) async {
    assertString(username);
    assertEitherOrStrings([artistName], mbid);

    return TagsList.parse(await _client.buildAndSubmit(
      'artist.getTags',
      rootTag: 'tags',
      args: {
        'artist': artistName,
        'mbid': mbid,
        'user': username,
        'autocorrect': autocorrect ?? false ? '1' : '0'
      },
    ));
  }

  Future<AlbumsList> getTopAlbums(
    String artistName, {
    String mbid,
    bool autocorrect,
    int page,
    int limit,
  }) async {
    assert(artistName != null || (mbid != null && mbid.isNotEmpty));
    assert(page == null || page >= 1);
    assert(limit == null || limit >= 1);

    return AlbumsList.parse(
      await _client.buildAndSubmit(
        'artist.getTopAlbums',
        rootTag: 'topAlbums',
        args: {
          'artist': artistName,
          'mbid': mbid,
          'autocorrect': autocorrect ?? false ? '1' : '0',
          'page': page?.toString(),
          'limit': limit?.toString()
        },
      ),
    );
  }

  Future<TagsList> getTopTags({
    String artistName,
    String mbid,
    bool autocorrect,
  }) async {
    assertEitherOrStrings([artistName], mbid);

    return TagsList.parse(await _client.buildAndSubmit(
      'artist.getTopTags',
      rootTag: 'topTags',
      args: {
        'artist': artistName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0'
      },
    ));
  }

  Future<TracksList> getTopTracks({
    String artistName,
    String mbid,
    bool autocorrect,
    int page,
    int limit,
  }) async {
    assert(artistName != null || (mbid != null && mbid.isNotEmpty));
    assert(page == null || page >= 1);
    assert(limit == null || limit >= 1);

    return TracksList.parse(
      await _client.buildAndSubmit(
        'artist.getTopTracks',
        rootTag: 'topTracks',
        args: {
          'artist': artistName,
          'mbid': mbid,
          'autocorrect': autocorrect ?? false ? '1' : '0',
          'page': page?.toString(),
          'limit': limit?.toString()
        },
      ),
    );
  }

  Future<ArtistsList> search(String artistName, {int limit, int page}) async {
    assertString(artistName);
    assertOptionalPositive(limit);
    assertOptionalPositive(page);

    const methodName = 'artist.search';

    final queryResult = await _client.buildAndSubmit(
      methodName,
      rootTag: 'results',
      args: {
        'artist': artistName,
        'page': page?.toString(),
        'limit': limit?.toString(),
      },
    );

    ApiException.checkMissingKeys(methodName, ['artistmatches'], queryResult);

    return ArtistsList.parse({
      ...queryResult['artistmatches'],
      '@attr': buildSearchAttr(methodName, queryResult),
    });
  }

  Future<bool> addTags(String artistName, List<String> tags) {
    assert(_client.isAuth);
    assertString(artistName);
    assert(tags != null && tags.isNotEmpty && tags.length <= 10);
    tags.forEach(assertString);

    return _client.buildAndSubmit('artist.addTags', args: {
      'artist': artistName,
      'tags': tags.join(',')
    }).then((value) => value.isEmpty);
  }

  Future<bool> removeTag(String artistName, String tagName) {
    assert(_client.isAuth);
    assertString(artistName);
    assertString(tagName);

    return _client.buildAndSubmit('artist.removeTag', args: {
      'artist': artistName,
      'tags': tagName,
    }).then((value) => value.isEmpty);
  }
}
