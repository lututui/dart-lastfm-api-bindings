import 'package:last_fm_api/datetime_period.dart';
import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/track/top_track_info.dart';
import 'package:last_fm_api/src/lists/base_top_list.dart';

class TopTracksList extends BaseTopList<TopTrackInfo> {
  TopTracksList(Map<String, dynamic> data, List<String> sources)
      : super(
          data['@attr'],
          (data['track'] as List).cast<Map<String, dynamic>>(),
          (element) => TopTrackInfo(element),
          sources,
        );

  TopTracksList.artist(Map<String, dynamic> data) : this(data, ['artist']);

  TopTracksList.chart(Map<String, dynamic> data) : this(data, ['chart']);

  TopTracksList.geo(Map<String, dynamic> data) : this(data, ['country']);

  TopTracksList.tag(Map<String, dynamic> data) : this(data, ['tag']);

  TopTracksList.user(Map<String, dynamic> data) : this(data, ['user']);

  factory TopTracksList.userChart(Map<String, dynamic> data) {
    final userString = 'user: ${decodeString(data['@attr']['user'])}';
    final dateTime = DateTimePeriod.parse(
      parseInt(data['@attr']['from']),
      parseInt(data['@attr']['to']),
    );

    return TopTracksList(data, [userString, dateTime.toString()]);
  }
}
