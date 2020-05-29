import 'dart:collection';

import 'package:last_fm_api/src/info/album/top_album_info.dart';
import 'package:last_fm_api/src/info/lists/base_list.dart';

class TopAlbumsList extends BaseList<TopAlbumInfo> {
  final String owner;

  List<TopAlbumInfo> get topAlbums => elements;

  TopAlbumsList(Map<String, dynamic> data)
      : owner = _buildOwner(data['@attr']),
        super(
            data['@attr'],
            (data['album'] as List).cast<Map<String, dynamic>>(),
            (element) => TopAlbumInfo(element));

  @override
  String toString() {
    return 'TopAlbumsList($owner, '
        '${IterableBase.iterableToFullString(topAlbums, '[', ']')})';
  }
}

String _buildOwner(Map<String, dynamic> attr) {
  final key = attr.keys.firstWhere((element) =>
      element == 'artist' || element == 'tag' || element == 'user');

  return '$key: ${attr[key]}';
}
