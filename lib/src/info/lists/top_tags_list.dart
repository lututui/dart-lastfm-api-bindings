import 'dart:collection';

import 'package:last_fm_api/src/info/lists/base_list.dart';
import 'package:last_fm_api/src/info/tag_info.dart';

class TopTagsList extends BaseList<TagInfo> {
  TopTagsList(Map<String, dynamic> data)
      : super(
          data['@attr'],
          (data['tag'] as List).cast<Map<String, dynamic>>(),
          (element) => TagInfo(element),
        );

  List<TagInfo> get topTags => elements;

  @override
  String toString() {
    return 'TopTagsList('
        '${IterableBase.iterableToFullString(topTags, '[', ']')})';
  }
}
