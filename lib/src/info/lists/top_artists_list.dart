import 'dart:collection';

import 'package:last_fm_api/src/info/artist/top_artist_info.dart';
import 'package:last_fm_api/src/info/lists/base_list.dart';

class TopArtistsList extends BaseList<TopArtistInfo> {
  List<TopArtistInfo> get topArtists => elements;

  TopArtistsList(Map<String, dynamic> data)
      : super(
          data['@attr'],
          (data['artist'] as List).cast<Map<String, dynamic>>(),
          (element) => TopArtistInfo(element),
        );

  @override
  String toString() {
    return 'TopArtistsList('
        '${IterableBase.iterableToFullString(topArtists, '[', ']')})';
  }
}
