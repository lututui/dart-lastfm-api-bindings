import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/info/lists/geo/geo_top_artists_list.dart';
import 'package:last_fm_api/src/info/lists/geo/geo_top_tracks_list.dart';

class LastFM_Geo {
  final APIClient _client;

  const LastFM_Geo(this._client);

  Future<GeoTopArtistsList> getTopArtists(String country,
      {int limit, int page}) async {
    assert(country != null && country.isNotEmpty);
    assert(limit == null || limit > 0);
    assert(page == null || page > 0);

    final methodString = r'geo.gettopartists';

    return GeoTopArtistsList(await _client
        .get(_client.buildUri(methodString, {
          'country': country,
          'limit': limit?.toString(),
          'page': page?.toString()
        }))
        .then((response) =>
            _client.assertOk(response, methodString, r'topartists')));
  }

  Future<GeoTopTracksList> getTopTracks(String country,
      {String location, int limit, int page}) async {
    assert(country != null && country.isNotEmpty);
    assert(limit == null || limit > 0);
    assert(page == null || page > 0);

    final methodString = r'geo.gettoptracks';

    return GeoTopTracksList(await _client
        .get(_client.buildUri(methodString, {
          'country': country,
          'location': location,
          'limit': limit?.toString(),
          'page': page?.toString()
        }))
        .then(
            (response) => _client.assertOk(response, methodString, 'tracks')));
  }
}
