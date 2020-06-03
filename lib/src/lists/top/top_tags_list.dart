import 'package:last_fm_api/src/info/tag_info.dart';
import 'package:last_fm_api/src/lists/base_top_list.dart';

class TopTagsList extends BaseTopList<TagInfo> {
  TopTagsList(Map<String, dynamic> data, List<String> sources)
      : super(
          data['@attr'],
          (data['tag'] as List).cast<Map<String, dynamic>>(),
          (element) => TagInfo.parse(element),
          sources,
        );

  TopTagsList.album(Map<String, dynamic> data) : this(data, ['album']);

  TopTagsList.artist(Map<String, dynamic> data) : this(data, ['artist']);

  TopTagsList.chart(Map<String, dynamic> data) : this(data, ['chart']);

  TopTagsList.tag(Map<String, dynamic> data) : this(data, ['global']);

  TopTagsList.track(Map<String, dynamic> data) : this(data, ['track']);

  TopTagsList.user(Map<String, dynamic> data) : this(data, ['user']);
}
