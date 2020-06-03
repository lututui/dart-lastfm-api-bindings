import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/lists/artists_list.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';

class LastFM_Chart {
  final LastFM_API_Client _client;

  const LastFM_Chart(this._client);

  Future<ArtistsList> getTopArtists({int page, int limit}) async {
    assert(page == null || page >= 1);
    assert(limit == null || limit >= 1);

    return ArtistsList(
      await _client.buildAndGet('chart.getTopArtists', 'artists', {
        'page': page?.toString(),
        'limit': limit?.toString(),
      }),
    );
  }

  Future<TagsList> getTopTags({int page, int limit}) async {
    assert(page == null || page >= 1);
    assert(limit == null || limit >= 1);

    return TagsList.parse(
      await _client.buildAndGet('chart.getTopTags', 'tags', {
        'page': page?.toString(),
        'limit': limit?.toString(),
      }),
    );
  }

  Future<TracksList> getTopTracks({int page, int limit}) async {
    assert(page == null || page >= 1);
    assert(limit == null || limit >= 1);

    return TracksList.parse(
      await _client.buildAndGet('chart.getTopTracks', 'tracks', {
        'page': page?.toString(),
        'limit': limit?.toString(),
      }),
    );
  }
}
