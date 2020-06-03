import 'package:last_fm_api/src/info/track/track_info.dart';
import 'package:last_fm_api/src/lists/base_list.dart';

class TracksList extends BaseList<TrackInfo> {
  TracksList(Map<String, dynamic> data)
      : super(
          (data['track'] as List).cast<Map<String, dynamic>>(),
          (element) => TrackInfo.parse(element),
        );

  @override
  String toShortString() {
    return '[${elements.map((trackInfo) => trackInfo.trackName).join(', ')}]';
  }
}
