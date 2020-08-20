import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/api_module.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/info/album_info.dart';
import 'package:last_fm_api/src/lists/albums_list.dart';
import 'package:last_fm_api/src/mixins/taggable.dart';

/// The 'album' module
///
/// {@category Module}
class LastFM_Album extends ApiModule with Taggable<AlbumInfo> {
  /// Creates a new instance for the 'album' module
  ///
  /// Usually created by [LastFM_API]
  const LastFM_Album(LastFM_API_Client client) : super('album', client);

  /// Get an album.
  ///
  /// Get the metadata and track list for an album on Last.fm as a [AlbumInfo]
  /// using [albumName] and [artistName] or a [mbid].
  ///
  /// {@template LastFmApi.autocorrect_template}
  /// If [autocorrect] is true, transforms misspelled names and returns the
  /// correct version.
  /// {@endtemplate}
  ///
  /// If [username] is given, that user's playcount for this album is included
  /// in the response.
  ///
  /// {@template LastFmApi.lang_template}
  /// The [lang] argument specifies the language to fetch the data in, expressed
  /// as an ISO 639 alpha-2 code.
  /// {@endtemplate}
  ///
  /// {@template LastFmApi.no_auth_template}
  /// This service does not require authentication
  /// {@category Unauthenticated}
  /// {@endtemplate}
  Future<AlbumInfo> getInfo({
    String artistName,
    String albumName,
    String mbid,
    bool autocorrect,
    String username,
    String lang,
  }) async {
    const methodName = 'album.getInfo';
    const rootTagName = 'album';

    if (mbid != null && mbid.isNotEmpty) {
      return AlbumInfo.parse(await client.buildAndSubmit(
        methodName,
        rootTag: rootTagName,
        args: {'mbid': mbid, 'username': username, 'lang': lang},
      ));
    } else if (artistName != null &&
        artistName.isNotEmpty &&
        albumName != null &&
        albumName.isNotEmpty) {
      return AlbumInfo.parse(await client.buildAndSubmit(
        methodName,
        rootTag: rootTagName,
        args: {
          'artist': artistName,
          'album': albumName,
          'autocorrect': boolToArgument(autocorrect),
          'username': username,
          'lang': lang,
        },
      ));
    }

    throw ArgumentError('Provide either album and artist names or a mbid');
  }

  /// Search for an album by name.
  ///
  /// Returns a [AlbumsList] with album matches for [albumName] sorted by
  /// relevance.
  ///
  /// {@template LastFmApi.search_limit_template}
  /// The [limit] is the number of results to fetch per page. This defaults to
  /// 30 results and must be at least 1.
  /// {@endtemplate}
  ///
  /// {@template LastFmApi.page_template}
  /// The [page] specifies which page should be fetched. Defaults to 1, the
  /// first page.
  /// {@endtemplate}
  ///
  /// {@macro LastFmApi.no_auth_template}
  Future<AlbumsList> search(
    String albumName, {
    int limit = 30,
    int page = 1,
  }) async {
    const methodName = 'album.search';

    if (limit < 1) throw RangeError.value(limit, 'limit');
    if (page < 1) throw RangeError.value(page, 'page');

    final queryResult = await client.buildAndSubmit(
      methodName,
      rootTag: 'results',
      args: {
        'album': albumName,
        'limit': limit?.toString(),
        'page': page?.toString(),
      },
    );

    LastFmApiException.checkMissingKeys(
        methodName, ['albummatches'], queryResult);

    return AlbumsList.parse({
      ...queryResult['albummatches'],
      '@attr': buildSearchAttr(methodName, queryResult),
    });
  }
}
