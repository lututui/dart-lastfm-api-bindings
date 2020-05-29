import 'dart:collection';

import 'package:last_fm_api/src/info/lists/geo_base_list.dart';
import 'package:last_fm_api/src/info/track/top_track_info.dart';

class GeoTopTracksList extends GeoBaseList<TopTrackInfo> {
  List<TopTrackInfo> get topTracks => elements;

  GeoTopTracksList(Map<String, dynamic> data)
      : super(
          data['@attr'],
          (data['track'] as List).cast<Map<String, dynamic>>(),
          (element) => TopTrackInfo(element),
        );

  @override
  String toString() {
    return 'GeoTopTracks($country, '
        '${IterableBase.iterableToFullString(topTracks, '[', ']')})';
  }
}
