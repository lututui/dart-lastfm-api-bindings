import 'package:last_fm_api/src/info/artist/top_artist_info.dart';
import 'package:last_fm_api/src/info/lists/base_top_list.dart';

class TopArtistsList extends BaseTopList<TopArtistInfo> {
  TopArtistsList(Map<String, dynamic> data, String sourceString)
      : super(
          data['@attr'],
          (data['artist'] as List).cast<Map<String, dynamic>>(),
          (element) => TopArtistInfo(element),
          sourceString,
        );

  TopArtistsList.chart(Map<String, dynamic> data) : this(data, 'chart');

  TopArtistsList.geo(Map<String, dynamic> data) : this(data, 'country');

  TopArtistsList.tag(Map<String, dynamic> data) : this(data, 'tag');

  TopArtistsList.user(Map<String, dynamic> data) : this(data, 'user');
}
