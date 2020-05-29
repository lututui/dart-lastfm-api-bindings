import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/info/lists/top_tracks_list.dart';

class LastFM_Tag {
  final LastFM_API_Client _client;

  LastFM_Tag(this._client);

  Future getInfo(String tagName, [String lang]) {
    throw UnimplementedError();
  }

  Future getSimilar(String tagName) {
    throw UnimplementedError();
  }

  Future getTopAlbums(String tagName, [int limit, int page]) {
    throw UnimplementedError();
  }

  Future getTopArtists(String tagName, [int limit, int page]) {
    throw UnimplementedError();
  }

  Future getTopTags() {
    throw UnimplementedError();
  }

  Future getTopTracks(String tagName, {int limit, int page}) async {
    assert(tagName != null && tagName.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return TopTracksList(await _client.buildAndGet(
        'tag.getTopTracks', 'tracks', {
      'tag': tagName,
      'limit': limit?.toString(),
      'page': page?.toString()
    }));
  }

  Future getWeeklyChartList(String tagName) {
    throw UnimplementedError();
  }
}
