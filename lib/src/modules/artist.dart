import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/api_module.dart';
import 'package:last_fm_api/src/assert.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/info/artist_info.dart';
import 'package:last_fm_api/src/lists/artists_list.dart';
import 'package:last_fm_api/src/mixins/taggable.dart';
import 'package:last_fm_api/src/mixins/top_albums.dart';
import 'package:last_fm_api/src/mixins/top_tracks.dart';

/// The 'artist' module
///
/// {@category Module}
class LastFM_Artist extends ApiModule
    with Taggable<ArtistInfo>, TopAlbums<ArtistInfo>, TopTracks<ArtistInfo> {
  /// Creates a new instance for the 'artist' module
  ///
  /// Usually created by [LastFM_API]
  const LastFM_Artist(LastFM_API_Client client) : super('artist', client);

  /// Corrects an artist's name
  ///
  /// Use the Last.fm corrections data to check whether the supplied
  /// [artistName] has a correction to a canonical artist.
  ///
  /// Returns a [ArtistInfo] with the corrected info.
  ///
  /// {@macro LastFmApi.no_auth_template}
  Future<ArtistInfo> getCorrection(String artistName) async {
    const methodName = 'artist.getCorrection';

    if (artistName == null || artistName.isEmpty) {
      throw ArgumentError('Invalid artist name: $artistName');
    }

    final queryResult = await client.buildAndSubmit(
      methodName,
      rootTag: 'corrections',
      args: {'artist': artistName},
    );

    LastFmApiException.checkMissingKeys(
      methodName,
      ['correction'],
      queryResult,
    );

    LastFmApiException.checkMissingKeys(
      methodName,
      ['artist'],
      queryResult['correction'],
    );

    return ArtistInfo.parse(queryResult['correction']['artist']);
  }

  /// Get an artist
  ///
  /// Get the metadata for an artist on Last.fm as a [ArtistInfo] using
  /// [artistName] or [mbid]. If available, includes biography, truncated at
  /// 300 characters.
  ///
  /// {@macro LastFmApi.autocorrect_template}
  ///
  /// If [username] is given, that user's playcount for this artist is included
  /// in the response.
  ///
  /// {@macro LastFmApi.lang_template}
  ///
  /// {@macro LastFmApi.no_auth_template}
  Future<ArtistInfo> getInfo({
    String artistName,
    String mbid,
    String lang,
    bool autocorrect,
    String username,
  }) async {
    const methodName = 'artist.getInfo';
    const rootTagName = 'artist';

    if (mbid != null && mbid.isNotEmpty) {
      return ArtistInfo.parse(await client.buildAndSubmit(
        methodName,
        rootTag: rootTagName,
        args: {
          'mbid': mbid,
          'lang': lang,
          'autocorrect': boolToArgument(autocorrect),
          'username': username,
        },
      ));
    } else if (artistName != null && artistName.isNotEmpty) {
      return ArtistInfo.parse(await client.buildAndSubmit(
        methodName,
        rootTag: rootTagName,
        args: {
          'artist': artistName,
          'lang': lang,
          'autocorrect': boolToArgument(autocorrect),
          'username': username,
        },
      ));
    }

    throw ArgumentError('Provide either an artist name or a mbid');
  }

  Future<ArtistsList> getSimilar({
    String artistName,
    String mbid,
    int limit,
    bool autocorrect,
  }) async {
    assertEitherOrStrings([artistName], mbid);
    assertOptionalPositive(limit);

    return ArtistsList.parse(await client.buildAndSubmit(
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

  Future<ArtistsList> search(String artistName, {int limit, int page}) async {
    assertString(artistName);
    assertOptionalPositive(limit);
    assertOptionalPositive(page);

    const methodName = 'artist.search';

    final queryResult = await client.buildAndSubmit(
      methodName,
      rootTag: 'results',
      args: {
        'artist': artistName,
        'page': page?.toString(),
        'limit': limit?.toString(),
      },
    );

    LastFmApiException.checkMissingKeys(
        methodName, ['artistmatches'], queryResult);

    return ArtistsList.parse({
      ...queryResult['artistmatches'],
      '@attr': buildSearchAttr(methodName, queryResult),
    });
  }
}
