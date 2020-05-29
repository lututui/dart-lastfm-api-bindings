import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/info/lists/top_artists_list.dart';
import 'package:last_fm_api/src/info/lists/top_tags_list.dart';
import 'package:last_fm_api/src/info/lists/top_tracks_list.dart';

class LastFM_Chart {
  final LastFM_API_Client _client;

  const LastFM_Chart(this._client);

  Future<TopArtistsList> getTopArtists({int page, int limit}) async {
    assert(page == null || page >= 1);
    assert(limit == null || limit >= 1);

    return TopArtistsList(await _client.buildAndGet('chart.getTopArtists',
        'artists', {'page': page?.toString(), 'limit': limit?.toString()}));
  }

  Future<TopTagsList> getTopTags({int page, int limit}) async {
    assert(page == null || page >= 1);
    assert(limit == null || limit >= 1);

    return TopTagsList(await _client.buildAndGet('chart.getTopTags', 'tags',
        {'page': page?.toString(), 'limit': limit?.toString()}));
  }

  Future<TopTracksList> getTopTracks({int page, int limit}) async {
    assert(page == null || page >= 1);
    assert(limit == null || limit >= 1);

    return TopTracksList(await _client.buildAndGet('chart.getTopTracks',
        'tracks', {'page': page?.toString(), 'limit': limit?.toString()}));
  }
}
