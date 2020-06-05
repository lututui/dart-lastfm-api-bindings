import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/assert.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/info/track_info.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';

class LastFM_Track {
  final LastFM_API_Client _client;

  const LastFM_Track(this._client) : assert(_client != null);

  Future addTags(String artistName, String trackName, List<String> tags) {
    throw UnimplementedError();
  }

  Future<TrackInfo> getCorrection(String artistName, String trackName) async {
    assert(artistName != null && artistName.isNotEmpty);
    assert(trackName != null && trackName.isNotEmpty);

    const methodName = 'track.getCorrection';

    final queryResult = await _client.buildAndGet(
      methodName,
      'corrections',
      {'artist': artistName, 'track': trackName},
    );

    ApiException.checkMissingKey(methodName, 'correction', queryResult);
    ApiException.checkMissingKey(
      methodName,
      'track',
      queryResult['correction'],
    );

    return TrackInfo.parse(queryResult['correction']['track']);
  }

  Future<TrackInfo> getInfo({
    String artistName,
    String trackName,
    String mbid,
    String usernamePlayCount,
    bool autocorrect,
  }) async {
    assert((artistName != null && trackName != null) || mbid != null);

    return TrackInfo.parse(await _client.buildAndGet(
      'track.getInfo',
      'track',
      {
        'artist': artistName,
        'track': trackName,
        'mbid': mbid,
        'username': usernamePlayCount,
        'autocorrect': autocorrect ?? false ? '1' : '0'
      },
    ));
  }

  Future<TracksList> getSimilar({
    String artistName,
    String trackName,
    String mbid,
    bool autocorrect,
    int limit,
  }) async {
    assertOptionalStrings([trackName, artistName], mbid);
    assertOptionalPositive(limit);

    return TracksList.parse(await _client.buildAndGet(
      'track.getSimilar',
      'similarTracks',
      {
        'track': trackName,
        'artist': artistName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0',
        'limit': limit?.toString()
      },
    ));
  }

  Future<TagsList> getTags(
    String user, {
    String artistName,
    String trackName,
    String mbid,
    bool autocorrect,
  }) async {
    assertString(user);
    assertOptionalStrings([trackName, artistName], mbid);

    return TagsList.parse(await _client.buildAndGet(
      'track.getTags',
      'tags',
      {
        'user': user,
        'track': trackName,
        'artist': artistName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0'
      },
    ));
  }

  Future<TagsList> getTopTags({
    String artistName,
    String trackName,
    String mbid,
    bool autocorrect,
  }) async {
    assertOptionalStrings([artistName, trackName], mbid);

    return TagsList.parse(await _client.buildAndGet(
      'track.getTopTags',
      'topTags',
      {
        'track': trackName,
        'artist': artistName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0'
      },
    ));
  }

  Future love(String artistName, String trackName) {
    throw UnimplementedError();
  }

  Future removeTag(String artistName, String trackName, String tagName) {
    throw UnimplementedError();
  }

  Future scrobble(Map<String, Map<String, String>> scrobbleInfo) {
    throw UnimplementedError();
  }

  Future<TracksList> search(
    String trackName, {
    String artistName,
    int page,
    int limit,
  }) async {
    assertString(trackName);
    assertOptionalPositive(page);
    assertOptionalPositive(limit);

    const methodName = 'track.search';

    final queryResult = await _client.buildAndGet(
      methodName,
      'results',
      {
        'track': trackName,
        'artist': artistName,
        'page': page?.toString(),
        'limit': limit?.toString()
      },
    );

    ApiException.checkMissingKey(methodName, 'trackmatches', queryResult);
    ApiException.checkMissingKey(methodName, 'opensearch:Query', queryResult);
    ApiException.checkMissingKey(
      methodName,
      'startPage',
      queryResult['opensearch:Query'],
    );
    ApiException.checkMissingKey(
      methodName,
      'opensearch:itemsPerPage',
      queryResult,
    );
    ApiException.checkMissingKey(
      methodName,
      'opensearch:totalResults',
      queryResult,
    );

    final perPage = parseInt(queryResult['opensearch:itemsPerPage']);
    final total = parseInt(queryResult['opensearch:totalResults']);

    return TracksList.parse({
      ...queryResult['trackmatches'],
      '@attr': {
        'page': queryResult['opensearch:Query']['startPage'],
        'perPage': perPage,
        'total': total,
        'totalPages': (total / perPage).ceil(),
      }
    });
  }

  Future unLove(String artistName, String trackName) {
    throw UnimplementedError();
  }

  Future updateNowPlaying(
    String artistName,
    String trackName, [
    String albumName,
    int trackNumber,
    String mbid,
    String duration,
    String albumArtist,
  ]) {
    throw UnimplementedError();
  }
}
