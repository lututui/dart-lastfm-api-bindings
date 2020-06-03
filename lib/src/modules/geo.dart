import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/lists/top/top_artists_list.dart';
import 'package:last_fm_api/src/lists/top/top_tracks_list.dart';

class LastFM_Geo {
  final LastFM_API_Client _client;

  const LastFM_Geo(this._client);

  Future<TopArtistsList> getTopArtists(
    String country, {
    int limit,
    int page,
  }) async {
    assert(country != null && country.isNotEmpty);
    assert(limit == null || limit > 0);
    assert(page == null || page > 0);

    return TopArtistsList.geo(
      await _client.buildAndGet('geo.getTopArtists', 'topArtists', {
        'country': country,
        'limit': limit?.toString(),
        'page': page?.toString(),
      }),
    );
  }

  Future<TopTracksList> getTopTracks(
    String country, {
    String location,
    int limit,
    int page,
  }) async {
    assert(country != null && country.isNotEmpty);
    assert(limit == null || limit > 0);
    assert(page == null || page > 0);

    return TopTracksList.geo(
      await _client.buildAndGet('geo.getTopTracks', 'tracks', {
        'country': country,
        'location': location,
        'limit': limit?.toString(),
        'page': page?.toString(),
      }),
    );
  }
}
