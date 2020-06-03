import 'package:last_fm_api/datetime_period.dart';
import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/artist/top_artist_info.dart';
import 'package:last_fm_api/src/lists/base_top_list.dart';

class TopArtistsList extends BaseTopList<TopArtistInfo> {
  TopArtistsList(Map<String, dynamic> data, List<String> sources)
      : super(
          data['@attr'],
          (data['artist'] as List).cast<Map<String, dynamic>>(),
          (element) => TopArtistInfo(element),
          sources,
        );

  TopArtistsList.chart(Map<String, dynamic> data) : this(data, ['chart']);

  TopArtistsList.geo(Map<String, dynamic> data) : this(data, ['country']);

  TopArtistsList.tag(Map<String, dynamic> data) : this(data, ['tag']);

  TopArtistsList.user(Map<String, dynamic> data) : this(data, ['user']);

  factory TopArtistsList.userChart(Map<String, dynamic> data) {
    final userString = 'user: ${decodeString(data['@attr']['user'])}';
    final dateTime = DateTimePeriod.parse(
      parseInt(data['@attr']['from']),
      parseInt(data['@attr']['to']),
    );

    return TopArtistsList(data, [userString, dateTime.toString()]);
  }
}
