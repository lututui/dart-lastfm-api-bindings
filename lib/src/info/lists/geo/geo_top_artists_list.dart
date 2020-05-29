import 'dart:collection';

import 'package:last_fm_api/src/info/artist/geo_top_artist_info.dart';
import 'package:last_fm_api/src/info/lists/geo_base_list.dart';

class GeoTopArtistsList extends GeoBaseList<GeoTopArtistInfo> {
  List<GeoTopArtistInfo> get topArtists => elements;

  GeoTopArtistsList(Map<String, dynamic> data)
      : super(
          data['@attr'],
          (data['artist'] as List).cast<Map<String, dynamic>>(),
          (element) => GeoTopArtistInfo(element),
        );

  @override
  String toString() {
    return 'GeoTopArtists($country, '
        '${IterableBase.iterableToFullString(topArtists, '[', ']')})';
  }
}
