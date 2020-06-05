import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/lists/artists_list.dart';

class LastFM_Library {
  final LastFM_API_Client _client;

  const LastFM_Library(this._client) : assert(_client != null);

  Future<ArtistsList> getArtists(String username, {int limit, int page}) async {
    assert(username != null && username.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return ArtistsList(await _client.buildAndGet(
      'library.getArtists',
      rootTag: 'artists',
      args: {
        'user': username,
        'limit': limit?.toString(),
        'page': page?.toString()
      },
    ));
  }
}
