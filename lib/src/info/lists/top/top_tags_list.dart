import 'package:last_fm_api/src/info/lists/base_top_list.dart';
import 'package:last_fm_api/src/info/tag_info.dart';

class TopTagsList extends BaseTopList<TagInfo> {
  TopTagsList(Map<String, dynamic> data, String sourceString)
      : super(
          data['@attr'],
          (data['tag'] as List).cast<Map<String, dynamic>>(),
          (element) => TagInfo.parse(element),
          sourceString,
        );

  TopTagsList.album(Map<String, dynamic> data) : this(data, 'album');

  TopTagsList.artist(Map<String, dynamic> data) : this(data, 'artist');

  TopTagsList.chart(Map<String, dynamic> data) : this(data, 'chart');

  TopTagsList.tag(Map<String, dynamic> data) : this(data, 'global');

  TopTagsList.track(Map<String, dynamic> data) : this(data, 'track');

  TopTagsList.user(Map<String, dynamic> data) : this(data, 'user');
}
