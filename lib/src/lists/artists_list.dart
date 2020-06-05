import 'package:last_fm_api/src/lists/base_list.dart';
import 'package:last_fm_api/src/lists/list_metadata.dart';

import 'file:///C:/Users/LuizArthurChagasOliv/Documents/GitHub/last_fm_api/lib/src/info/artist_info.dart';

class ArtistsList extends BaseList<ArtistInfo> {
  ArtistsList(Map<String, dynamic> data)
      : super(
          (data['artist'] as List).cast<Map<String, dynamic>>(),
          (element) => ArtistInfo.parse(element),
          ListMetadata.parse(data['@attr']),
        );
}
