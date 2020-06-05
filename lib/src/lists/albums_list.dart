import 'package:last_fm_api/src/lists/base_list.dart';
import 'package:last_fm_api/src/lists/list_metadata.dart';

import 'file:///C:/Users/LuizArthurChagasOliv/Documents/GitHub/last_fm_api/lib/src/info/album_info.dart';

class AlbumsList extends BaseList<AlbumInfo> {
  AlbumsList(Map<String, dynamic> data)
      : super(
          (data['album'] as List).cast<Map<String, dynamic>>(),
          (element) => AlbumInfo.parse(element),
          ListMetadata.parse(data['@attr']),
        );
}
