import 'package:last_fm_api/datetime_period.dart';
import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/api_module.dart';
import 'package:last_fm_api/src/info/tag_info.dart';
import 'package:last_fm_api/src/lists/artists_list.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';
import 'package:last_fm_api/src/mixins/top_albums.dart';
import 'package:last_fm_api/src/mixins/top_tracks.dart';

class LastFM_Tag extends ApiModule with TopAlbums<TagInfo>, TopTracks<TagInfo> {
  const LastFM_Tag(LastFM_API_Client client) : super('tag', client);

  Future<TagInfo> getInfo(String tagName, {String lang}) async {
    assert(tagName != null && tagName.isNotEmpty);

    return TagInfo.parse(await client.buildAndSubmit(
      'tag.getInfo',
      rootTag: 'tag',
      args: {'tag': tagName, 'lang': lang},
    ));
  }

  Future<TagsList> getSimilar(String tagName) async {
    assert(tagName != null && tagName.isNotEmpty);

    return TagsList.parse(await client.buildAndSubmit(
      'tag.getSimilar',
      rootTag: 'similarTags',
      args: {'tag': tagName},
    ));
  }

  Future<ArtistsList> getTopArtists(
    String tagName, {
    int limit,
    int page,
  }) async {
    assert(tagName != null && tagName.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return ArtistsList.parse(await client.buildAndSubmit(
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
      await client.buildAndSubmit('tag.getTopTags', rootTag: 'topTags'),
    );
  }

  Future<List<DateTimePeriod>> getWeeklyChartList(String tagName) async {
    assert(tagName != null && tagName.isNotEmpty);

    final queryResult = ((await client.buildAndSubmit(
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
