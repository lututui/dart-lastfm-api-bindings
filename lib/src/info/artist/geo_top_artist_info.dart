import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/artist/artist_info.dart';
import 'package:last_fm_api/src/info/image.dart';

class GeoTopArtistInfo extends ArtistInfo {
  GeoTopArtistInfo._(
    API_Images artistImages,
    String artistName,
    String mbid,
    String artistUrl,
    bool streamable,
    int listeners,
  ) : super(
          artistName: artistName,
          mbid: mbid,
          artistUrl: artistUrl,
          artistImages: artistImages,
          streamable: streamable,
          listeners: listeners,
        );

  factory GeoTopArtistInfo(Map<String, dynamic> data) {
    return GeoTopArtistInfo._(
      API_Images((data['image'] as List).cast<Map<String, dynamic>>()),
      decodeString(data['name']),
      data['mbid'],
      data['url'],
      parseStreamable(data['streamable']),
      int.parse(data['listeners']),
    );
  }

  @override
  String toString() => 'GeoTopArtistInfo($artistName, $listeners)';
}
