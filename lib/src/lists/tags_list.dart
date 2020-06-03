import 'package:last_fm_api/src/info/tag_info.dart';
import 'package:last_fm_api/src/lists/base_list.dart';
import 'package:last_fm_api/src/lists/list_metadata.dart';

class TagsList extends BaseList<TagInfo> {
  TagsList(List<Map<String, dynamic>> listData, ListMetadata metadata)
      : super(listData, (element) => TagInfo.parse(element), metadata);

  factory TagsList.parse(Map<String, dynamic> data) {
    if (data == null) return null;

    return TagsList(
      (data['tag'] as List).cast<Map<String, dynamic>>(),
      ListMetadata.parse(data['@attr']),
    );
  }
}
