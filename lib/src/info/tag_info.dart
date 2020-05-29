import 'package:last_fm_api/src/api_base.dart';

class TagInfo {
  final String tagName;
  final String tagUrl;
  final int tagReach;
  final int taggings;
  final bool streamable;
  final String published;
  final String summary;
  final String content;

  TagInfo._(
    this.tagName,
    this.tagUrl,
    this.tagReach,
    this.taggings,
    this.streamable,
    this.published,
    this.summary,
    this.content,
  );

  factory TagInfo(Map<String, dynamic> data) {
    return TagInfo._(
      decodeString(data['name']),
      data['url'],
      int.parse(data['reach']),
      int.parse(data['taggings']),
      parseStreamable(data['streamable']),
      data['wiki']['published'],
      data['wiki']['summary'],
      data['wiki']['content'],
    );
  }

  @override
  String toString() {
    return 'TagInfo($tagName)';
  }
}
