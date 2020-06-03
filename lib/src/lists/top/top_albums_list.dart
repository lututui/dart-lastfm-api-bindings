import 'package:last_fm_api/datetime_period.dart';
import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/album/top_album_info.dart';
import 'package:last_fm_api/src/lists/base_top_list.dart';

class TopAlbumsList extends BaseTopList<TopAlbumInfo> {
  TopAlbumsList(Map<String, dynamic> data, List<String> sources)
      : super(
          data['@attr'],
          (data['album'] as List).cast<Map<String, dynamic>>(),
          (element) => TopAlbumInfo.parse(element),
          sources,
        );

  TopAlbumsList.artist(Map<String, dynamic> data) : this(data, ['artist']);

  TopAlbumsList.tag(Map<String, dynamic> data) : this(data, ['tag']);

  TopAlbumsList.user(Map<String, dynamic> data) : this(data, ['user']);

  factory TopAlbumsList.userChart(Map<String, dynamic> data) {
    final userString = 'user: ${decodeString(data['@attr']['user'])}';
    final dateTime = DateTimePeriod.parse(
      parseInt(data['@attr']['from']),
      parseInt(data['@attr']['to']),
    );

    return TopAlbumsList(data, [userString, dateTime.toString()]);
  }
}
