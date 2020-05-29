import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/info/lists/top_artists_list.dart';
import 'package:last_fm_api/src/info/lists/top_tags_list.dart';

class LastFM_Chart {
  final APIClient _client;

  const LastFM_Chart(this._client);

  Future<TopArtistsList> getTopArtists({int page, int limit}) async {
    final methodString = r'chart.gettopartists';

    return TopArtistsList(await _client
        .get(_client.buildUri(methodString,
            {'page': page?.toString(), 'limit': limit?.toString()}))
        .then(
            (response) => _client.assertOk(response, methodString, 'artists')));
  }

  Future<TopTagsList> getTopTags({int page, int limit}) async {
    final methodString = r'chart.gettoptags';

    return TopTagsList(await _client
        .get(_client.buildUri(methodString,
            {'page': page?.toString(), 'limit': limit?.toString()}))
        .then((response) => _client.assertOk(response, methodString, 'tags')));
  }

  Future getTopTracks([int page, int limit]) {
    throw UnimplementedError();
  }
}
