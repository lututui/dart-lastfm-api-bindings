import 'package:last_fm_api/src/info/lists/base_top_list.dart';
import 'package:last_fm_api/src/info/track/top_track_info.dart';

class TopTracksList extends BaseTopList<TopTrackInfo> {
  TopTracksList(Map<String, dynamic> data, String sourceString)
      : super(
          data['@attr'],
          (data['track'] as List).cast<Map<String, dynamic>>(),
          (element) => TopTrackInfo(element),
          sourceString,
        );

  TopTracksList.artist(Map<String, dynamic> data) : this(data, 'artist');

  TopTracksList.chart(Map<String, dynamic> data) : this(data, 'chart');

  TopTracksList.geo(Map<String, dynamic> data) : this(data, 'country');

  TopTracksList.tag(Map<String, dynamic> data) : this(data, 'tag');

  TopTracksList.user(Map<String, dynamic> data) : this(data, 'user');
}
