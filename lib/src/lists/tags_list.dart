import 'package:last_fm_api/src/info/tag_info.dart';
import 'package:last_fm_api/src/lists/base_list.dart';

class TagsList extends BaseList<TagInfo> {
  TagsList(Map<String, dynamic> data)
      : super(
          (data['tag'] as List).cast<Map<String, dynamic>>(),
          (element) => TagInfo.parse(element),
        );
}
