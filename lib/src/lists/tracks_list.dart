import 'package:last_fm_api/src/info/track_info.dart';
import 'package:last_fm_api/src/lists/base_list.dart';
import 'package:last_fm_api/src/lists/list_metadata.dart';

class TracksList extends BaseList<TrackInfo> {
  TracksList(List<Map<String, dynamic>> listData, ListMetadata metadata)
      : super(listData, (element) => TrackInfo.parse(element), metadata);

  factory TracksList.parse(Map<String, dynamic> data) {
    if (data == null) return null;

    return TracksList(
      (data['track'] as List).cast<Map<String, dynamic>>(),
      ListMetadata.parse(data['@attr']),
    );
  }

  @override
  String toShortString() {
    return '[${elements.map((trackInfo) => trackInfo.trackName).join(', ')}]';
  }
}
