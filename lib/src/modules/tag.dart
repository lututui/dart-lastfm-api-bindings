import 'package:last_fm_api/datetime_period.dart';
import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/info/tag_info.dart';
import 'package:last_fm_api/src/lists/albums_list.dart';
import 'package:last_fm_api/src/lists/artists_list.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';

class LastFM_Tag {
  final LastFM_API_Client _client;

  const LastFM_Tag(this._client) : assert(_client != null);

  Future<TagInfo> getInfo(String tagName, {String lang}) async {
    assert(tagName != null && tagName.isNotEmpty);

    return TagInfo.parse(await _client.buildAndGet(
      'tag.getInfo',
      rootTag: 'tag',
      args: {'tag': tagName, 'lang': lang},
    ));
  }

  Future<TagsList> getSimilar(String tagName) async {
    assert(tagName != null && tagName.isNotEmpty);

    return TagsList.parse(await _client.buildAndGet(
      'tag.getSimilar',
      rootTag: 'similarTags',
      args: {'tag': tagName},
    ));
  }

  Future<AlbumsList> getTopAlbums(
    String tagName, {
    int limit,
    int page,
  }) async {
    assert(tagName != null && tagName.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return AlbumsList.parse(
      await _client.buildAndGet('tag.getTopAlbums', rootTag: 'albums', args: {
        'tag': tagName,
        'limit': limit?.toString(),
        'page': page?.toString(),
      }),
    );
  }

  Future<ArtistsList> getTopArtists(
    String tagName, {
    int limit,
    int page,
  }) async {
    assert(tagName != null && tagName.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return ArtistsList(await _client.buildAndGet(
      'tag.getTopArtists',
      rootTag: 'topArtists',
      args: {
        'tag': tagName,
        'limit': limit?.toString(),
        'page': page?.toString()
      },
    ));
  }

  Future<TagsList> getTopTags() async {
    return TagsList.parse(
      await _client.buildAndGet('tag.getTopTags', rootTag: 'topTags'),
    );
  }

  Future<TracksList> getTopTracks(
    String tagName, {
    int limit,
    int page,
  }) async {
    assert(tagName != null && tagName.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return TracksList.parse(
      await _client.buildAndGet('tag.getTopTracks', rootTag: 'tracks', args: {
        'tag': tagName,
        'limit': limit?.toString(),
        'page': page?.toString(),
      }),
    );
  }

  Future<List<DateTimePeriod>> getWeeklyChartList(String tagName) async {
    assert(tagName != null && tagName.isNotEmpty);

    final queryResult = ((await _client.buildAndGet(
      'tag.getWeeklyChartList',
      rootTag: 'weeklyChartList',
      args: {'tag': tagName},
    ))['chart'] as List)
        .cast<Map<String, dynamic>>();

    return [
      for (final entry in queryResult)
        DateTimePeriod.parse(parseInt(entry['from']), parseInt(entry['to']))
    ];
  }
}
