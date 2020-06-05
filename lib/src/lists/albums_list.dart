import 'package:last_fm_api/src/info/album_info.dart';
import 'package:last_fm_api/src/lists/base_list.dart';
import 'package:last_fm_api/src/lists/list_metadata.dart';

class AlbumsList extends BaseList<AlbumInfo> {
  AlbumsList(List<Map<String, dynamic>> listData, ListMetadata metadata)
      : super(listData, (element) => AlbumInfo.parse(element), metadata);

  factory AlbumsList.parse(Map<String, dynamic> data) {
    return AlbumsList(
      (data['album'] as List).cast<Map<String, dynamic>>(),
      ListMetadata.parse(data['@attr']),
    );
  }
}
