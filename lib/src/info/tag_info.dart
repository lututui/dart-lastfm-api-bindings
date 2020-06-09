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

  const TagInfo({
    this.tagName,
    this.tagUrl,
    this.tagReach,
    this.taggings,
    this.streamable,
    this.published,
    this.summary,
    this.content,
  });

  TagInfo.parse(Map<String, dynamic> data)
      : this(
          tagName: decodeString(data['name']),
          tagUrl: data['url'],
          tagReach: parseInt(data['reach']),
          taggings: parseInt(data['taggings'] ?? data['count']),
          streamable: parseBool(data['streamable']),
          published: (data['wiki'] ?? const {})['published'],
          summary: (data['wiki'] ?? const {})['summary'],
          content: (data['wiki'] ?? const {})['content'],
        );

  @override
  String toString() {
    return 'TagInfo(${[
      tagName,
      [tagReach, taggings]
          .where((element) => element != null && element > 0)
          .join(', ')
    ].where((element) => element.isNotEmpty).join(', ')})';
  }
}
