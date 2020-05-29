import 'dart:collection';

import 'package:last_fm_api/src/info/lists/base_list.dart';
import 'package:last_fm_api/src/info/track/top_track_info.dart';

class TopTracksList extends BaseList<TopTrackInfo> {
  List<TopTrackInfo> get topTracks => elements;

  TopTracksList(Map<String, dynamic> data)
      : super(
          data['@attr'],
          (data['track'] as List).cast<Map<String, dynamic>>(),
          (element) => TopTrackInfo(element),
        );

  @override
  String toString() {
    return 'TopTracks('
        '${IterableBase.iterableToFullString(topTracks, '[', ']')})';
  }
}
