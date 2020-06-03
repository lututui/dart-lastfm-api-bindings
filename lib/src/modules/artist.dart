import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/lists/albums_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';

class LastFM_Artist {
  final LastFM_API_Client _client;

  const LastFM_Artist(this._client);

  /// Requires auth
  Future addTags(String artistName, List<String> tags) {
    throw UnimplementedError();
  }

  Future getCorrection(String artistName) {
    throw UnimplementedError();
  }

  Future getInfo(
    String artistName, [
    String mbid,
    String lang,
    bool autocorrect,
    String usernamePlayCount,
  ]) {
    throw UnimplementedError();
  }

  Future getSimilar(
    String artistName, [
    String mbid,
    int limit,
    bool autocorrect,
  ]) {
    throw UnimplementedError();
  }

  Future getTags(
    String artistName, [
    String mbid,
    String username,
    bool autocorrect,
  ]) {
    throw UnimplementedError();
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

    return AlbumsList(
      await _client.buildAndGet('artist.getTopAlbums', 'topAlbums', {
        'artist': artistName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0',
        'page': page?.toString(),
        'limit': limit?.toString(),
      }),
    );
  }

  Future getTopTags(String artistName, [String mbid, bool autocorrect]) {
    throw UnimplementedError();
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
      await _client.buildAndGet('artist.getTopTracks', 'topTracks', {
        'artist': artistName,
        'mbid': mbid,
        'autocorrect': autocorrect ?? false ? '1' : '0',
        'page': page?.toString(),
        'limit': limit?.toString(),
      }),
    );
  }

  /// Requires auth
  Future removeTag(String artistName, String tag) {
    throw UnimplementedError();
  }

  Future search(String artistName, [int limit, int page]) {
    throw UnimplementedError();
  }
}
