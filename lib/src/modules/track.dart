import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/assert.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/info/scrobble_info.dart';
import 'package:last_fm_api/src/info/track_info.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';

class LastFM_Track {
  final LastFM_API_Client _client;

  const LastFM_Track(this._client) : assert(_client != null);

  Future<TrackInfo> getCorrection(String artistName, String trackName) async {
    assert(artistName != null && artistName.isNotEmpty);
    assert(trackName != null && trackName.isNotEmpty);

    const methodName = 'track.getCorrection';

    final queryResult = await _client.buildAndSubmit(
      methodName,
      rootTag: 'corrections',
      args: {'artist': artistName, 'track': trackName},
    );

    ApiException.checkMissingKeys(methodName, ['correction'], queryResult);
    ApiException.checkMissingKeys(
      methodName,
      ['track'],
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

    return TrackInfo.parse(await _client.buildAndSubmit(
      'track.getInfo',
      rootTag: 'track',
      args: {
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
    assertEitherOrStrings([trackName, artistName], mbid);
    assertOptionalPositive(limit);

    return TracksList.parse(await _client.buildAndSubmit(
      'track.getSimilar',
      rootTag: 'similarTracks',
      args: {
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
    assertEitherOrStrings([trackName, artistName], mbid);

    return TagsList.parse(await _client.buildAndSubmit(
      'track.getTags',
      rootTag: 'tags',
      args: {
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
    assertEitherOrStrings([artistName, trackName], mbid);

    return TagsList.parse(await _client.buildAndSubmit(
      'track.getTopTags',
      rootTag: 'topTags',
      args: {
        'track': trackName,
        'artist': artistName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0'
      },
    ));
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

    final queryResult = await _client.buildAndSubmit(
      methodName,
      rootTag: 'results',
      args: {
        'track': trackName,
        'artist': artistName,
        'page': page?.toString(),
        'limit': limit?.toString()
      },
    );

    ApiException.checkMissingKeys(methodName, ['trackmatches'], queryResult);

    return TracksList.parse({
      ...queryResult['trackmatches'],
      '@attr': buildSearchAttr(methodName, queryResult),
    });
  }

  Future love(String artistName, String trackName) {
    assert(_client.isAuth);
    assertString(artistName);
    assertString(trackName);

    return _client.buildAndSubmit(
      'track.love',
      args: {'artist': artistName, 'track': trackName},
    );
  }

  Future unlove(String artistName, String trackName) {
    assert(_client.isAuth);
    assertString(artistName);
    assertString(trackName);

    return _client.buildAndSubmit(
      'track.unlove',
      args: {'artist': artistName, 'track': trackName},
    );
  }

  Future<ScrobbleInfo> updateNowPlaying(
    String artistName,
    String trackName, {
    String albumName,
    int trackNumber,
    String mbid,
    Duration duration,
    String albumArtist,
    String context,
  }) async {
    assertString(artistName);
    assertString(trackName);
    assertOptionalString(albumName);
    assertOptionalPositive(trackNumber);
    assertOptionalString(mbid);
    assertOptionalPositive(duration?.inSeconds);
    assertOptionalString(albumArtist);
    assertOptionalString(context);

    const methodName = 'track.updateNowPlaying';

    final queryResult = await _client.buildAndSubmit(
      methodName,
      rootTag: 'nowPlaying',
      args: {
        'artist': artistName,
        'track': trackName,
        'album': albumName,
        'trackNumber': trackNumber?.toString(),
        'mbid': mbid,
        'duration': duration?.inSeconds?.toString(),
        'albumArtist': albumArtist,
        'context': context
      },
    );

    ApiException.checkMissingKeys(
      methodName,
      ['artist', 'ignoredMessage', 'album', 'albumArtist', 'track'],
      queryResult,
    );

    return ScrobbleInfo.parse(queryResult);
  }

  Future scrobble(
    String artistName,
    String trackName,
    DateTime timestamp, {
    String albumName,
    String mbid,
    String albumArtist,
    Duration duration,
    int trackNumber,
    bool chosenByUser,
    String streamId,
    String context,
  }) async {
    assert(_client.isAuth);
    assertString(artistName);
    assertString(trackName);
    assert(timestamp != null);
    assertOptionalString(albumName);
    assertOptionalString(mbid);
    assertOptionalString(albumArtist);
    assertOptionalPositive(duration?.inSeconds);
    assertOptionalPositive(trackNumber);
    assertOptionalString(streamId);
    assertOptionalString(context);

    const methodName = 'track.scrobble';

    final queryResult = await _client.buildAndSubmit(
      methodName,
      rootTag: 'scrobbles',
      args: {
        'artist': artistName,
        'track': trackName,
        'timestamp': (timestamp.millisecondsSinceEpoch ~/ 1000).toString(),
        'album': albumName,
        'context': context,
        'streamId': streamId,
        'chosenByUser': chosenByUser ?? false ? '1' : '0',
        'trackNumber': trackNumber?.toString(),
        'mbid': mbid,
        'albumArtist': albumArtist,
        'duration': duration?.inSeconds?.toString(),
      },
    );

    ApiException.checkMissingKeys(
      methodName,
      [
        'artist',
        'ignoredMessage',
        'album',
        'albumArtist',
        'track',
        'timestamp'
      ],
      queryResult,
    );

    return ScrobbleInfo.parse(queryResult);
  }

  Future<bool> addTags(String artistName, String trackName, List<String> tags) {
    assert(_client.isAuth);
    assertString(artistName);
    assertString(trackName);
    assert(tags != null && tags.isNotEmpty && tags.length <= 10);
    tags.forEach(assertString);

    return _client.buildAndSubmit('track.addTags', args: {
      'artist': artistName,
      'track': trackName,
      'tags': tags.join(',')
    }).then((value) => value.isEmpty);
  }

  Future<bool> removeTag(String artistName, String trackName, String tagName) {
    assert(_client.isAuth);
    assertString(artistName);
    assertString(trackName);
    assertString(tagName);

    return _client.buildAndSubmit('track.removeTag', args: {
      'artist': artistName,
      'track': trackName,
      'tags': tagName,
    }).then((value) => value.isEmpty);
  }
}
