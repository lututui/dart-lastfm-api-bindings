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

  factory TagInfo.parse(Map<String, dynamic> data) {
    final wiki = data['wiki'] ?? const {};

    return TagInfo(
      tagName: decodeString(data['name']),
      tagUrl: data['url'],
      tagReach: parseInt(data['reach']),
      taggings: parseInt(data['taggings']),
      streamable: parseStreamable(data['streamable']),
      published: wiki['published'],
      summary: wiki['summary'],
      content: wiki['content'],
    );
  }

  @override
  String toString() {
    return 'TagInfo($tagName)';
  }
}
