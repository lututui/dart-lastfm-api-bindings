import 'dart:collection';

import 'package:last_fm_api/src/info/lists/geo_base_list.dart';
import 'package:last_fm_api/src/info/track/geo_top_track_info.dart';

class GeoTopTracksList extends GeoBaseList<GeoTopTrackInfo> {
  List<GeoTopTrackInfo> get topTracks => elements;

  GeoTopTracksList(Map<String, dynamic> data)
      : super(
          data['@attr'],
          (data['track'] as List).cast<Map<String, dynamic>>(),
          (element) => GeoTopTrackInfo(element),
        );

  @override
  String toString() {
    return 'GeoTopTracks($country, '
        '${IterableBase.iterableToFullString(topTracks, '[', ']')})';
  }
}
