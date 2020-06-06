import 'package:last_fm_api/src/info/artist_info.dart';
import 'package:last_fm_api/src/lists/base_list.dart';
import 'package:last_fm_api/src/lists/list_metadata.dart';

class ArtistsList extends BaseList<ArtistInfo> {
  ArtistsList(List<Map<String, dynamic>> listData, ListMetadata metadata)
      : super(listData, (element) => ArtistInfo.parse(element), metadata);

  factory ArtistsList.parse(Map<String, dynamic> data) {
    return ArtistsList(
      (data['artist'] as List).cast<Map<String, dynamic>>(),
      ListMetadata.parse(data['@attr']),
    );
  }
}
