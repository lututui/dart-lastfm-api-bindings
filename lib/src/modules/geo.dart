import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/lists/artists_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';

class LastFM_Geo {
  final LastFM_API_Client _client;

  const LastFM_Geo(this._client);

  Future<ArtistsList> getTopArtists(
    String country, {
    int limit,
    int page,
  }) async {
    assert(country != null && country.isNotEmpty);
    assert(limit == null || limit > 0);
    assert(page == null || page > 0);

    return ArtistsList.parse(
      await _client.buildAndSubmit(
        'geo.getTopArtists',
        rootTag: 'topArtists',
        args: {
          'country': country,
          'limit': limit?.toString(),
          'page': page?.toString(),
        },
      ),
    );
  }

  Future<TracksList> getTopTracks(
    String country, {
    String location,
    int limit,
    int page,
  }) async {
    assert(country != null && country.isNotEmpty);
    assert(limit == null || limit > 0);
    assert(page == null || page > 0);

    return TracksList.parse(
      await _client.buildAndSubmit('geo.getTopTracks', rootTag: 'tracks', args: {
        'country': country,
        'location': location,
        'limit': limit?.toString(),
        'page': page?.toString(),
      }),
    );
  }
}
