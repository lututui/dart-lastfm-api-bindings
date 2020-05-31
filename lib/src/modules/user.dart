import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/info/lists/top/top_albums_list.dart';
import 'package:last_fm_api/src/info/lists/top/top_tracks_list.dart';
import 'package:last_fm_api/src/period.dart';

class LastFM_User {
  final LastFM_API_Client _client;

  const LastFM_User(this._client);

  Future getFriends(String username, [bool recentTracks, int limit, int page]) {
    throw UnimplementedError();
  }

  Future getInfo(String username) {
    throw UnimplementedError();
  }

  Future getLovedTracks(String username, [int limit, int page]) {
    throw UnimplementedError();
  }

  Future getPersonalTags(String username, String tag, String taggingType,
      [int limit, int page]) {
    throw UnimplementedError();
  }

  Future getRecentTags(String username,
      [int limit,
      int page,
      int fromTimestamp,
      bool extended,
      int toTimestamp]) {
    throw UnimplementedError();
  }

  Future<TopAlbumsList> getTopAlbums(
    String username, {
    LastFM_Period period,
    int limit,
    int page,
  }) async {
    return TopAlbumsList.user(
      await _client.buildAndGet('user.getTopAlbums', 'topAlbums', {
        'user': username,
        'period': period?.toString(),
        'limit': limit?.toString(),
        'page': page?.toString()
      }),
    );
  }

  Future getTopArtists(String username,
      [LastFM_Period period, int limit, int page]) {
    throw UnimplementedError();
  }

  Future getTopTags(String username, [int limit]) {
    throw UnimplementedError();
  }

  Future<TopTracksList> getTopTracks(
    String username, {
    LastFM_Period period,
    int limit,
    int page,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return TopTracksList.user(
      await _client.buildAndGet('user.getTopTracks', 'topTracks', {
        'user': username,
        'period': period?.toString(),
        'limit': limit?.toString(),
        'page': page?.toString()
      }),
    );
  }

  Future getWeeklyAlbumChart(String username, [String from, String to]) {
    throw UnimplementedError();
  }

  Future getWeeklyArtistChart(String username, [String from, String to]) {
    throw UnimplementedError();
  }

  Future getWeeklyChartList(String username) {
    throw UnimplementedError();
  }

  Future getWeeklyTrackChart(String username, [String from, String to]) {
    throw UnimplementedError();
  }
}
