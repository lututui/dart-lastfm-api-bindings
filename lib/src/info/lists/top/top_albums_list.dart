import 'package:last_fm_api/src/info/album/top_album_info.dart';
import 'package:last_fm_api/src/info/lists/base_top_list.dart';

class TopAlbumsList extends BaseTopList<TopAlbumInfo> {
  TopAlbumsList(Map<String, dynamic> data, String sourceType)
      : super(
          data['@attr'],
          (data['album'] as List).cast<Map<String, dynamic>>(),
          (element) => TopAlbumInfo(element),
          sourceType,
        );

  TopAlbumsList.artist(Map<String, dynamic> data) : this(data, 'artist');

  TopAlbumsList.tag(Map<String, dynamic> data) : this(data, 'tag');

  TopAlbumsList.user(Map<String, dynamic> data) : this(data, 'user');
}
