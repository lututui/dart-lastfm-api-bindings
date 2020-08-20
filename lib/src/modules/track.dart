import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/api_module.dart';
import 'package:last_fm_api/src/assert.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/info/scrobble_info.dart';
import 'package:last_fm_api/src/info/track_info.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';
import 'package:last_fm_api/src/mixins/taggable.dart';

class LastFM_Track extends ApiModule with Taggable<TrackInfo> {
  const LastFM_Track(LastFM_API_Client client) : super('track', client);

  Future<TrackInfo> getCorrection(String artistName, String trackName) async {
    assert(artistName != null && artistName.isNotEmpty);
    assert(trackName != null && trackName.isNotEmpty);

    const methodName = 'track.getCorrection';

    final queryResult = await client.buildAndSubmit(
      methodName,
      rootTag: 'corrections',
      args: {'artist': artistName, 'track': trackName},
    );

    LastFmApiException.checkMissingKeys(
        methodName, ['correction'], queryResult);
    LastFmApiException.checkMissingKeys(
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

    return TrackInfo.parse(await client.buildAndSubmit(
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

    return TracksList.parse(await client.buildAndSubmit(
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

    final queryResult = await client.buildAndSubmit(
      methodName,
      rootTag: 'results',
      args: {
        'track': trackName,
        'artist': artistName,
        'page': page?.toString(),
        'limit': limit?.toString()
      },
    );

    LastFmApiException.checkMissingKeys(
        methodName, ['trackmatches'], queryResult);

    return TracksList.parse({
      ...queryResult['trackmatches'],
      '@attr': buildSearchAttr(methodName, queryResult),
    });
  }

  Future love(String artistName, String trackName) {
    assert(client.isAuth);
    assertString(artistName);
    assertString(trackName);

    return client.buildAndSubmit(
      'track.love',
      args: {'artist': artistName, 'track': trackName},
    );
  }

  Future unlove(String artistName, String trackName) {
    assert(client.isAuth);
    assertString(artistName);
    assertString(trackName);

    return client.buildAndSubmit(
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

    final queryResult = await client.buildAndSubmit(
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

    LastFmApiException.checkMissingKeys(
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
    assert(client.isAuth);
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

    final queryResult = await client.buildAndSubmit(
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

    LastFmApiException.checkMissingKeys(
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
}
