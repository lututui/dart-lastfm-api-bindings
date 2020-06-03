import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/artist/artist_info.dart';
import 'package:last_fm_api/src/info/image.dart';

class TopArtistInfo extends ArtistInfo {
  TopArtistInfo._(
    String artistName,
    int playCount,
    int listeners,
    String mbid,
    String artistUrl,
    bool streamable,
    ImageInfo artistImages,
  ) : super(
          artistName: artistName,
          playCount: playCount,
          listeners: listeners,
          mbid: mbid,
          artistUrl: artistUrl,
          streamable: streamable,
          artistImages: artistImages,
        );

  factory TopArtistInfo(Map<String, dynamic> data) {
    return TopArtistInfo._(
      decodeString(data['name']),
      parseInt(data['playcount']),
      parseInt(data['listeners']),
      data['mbid'],
      data['artistUrl'],
      parseStreamable(data['streamable']),
      data['image'] != null ? ImageInfo.parse(data['image']) : null,
    );
  }

  @override
  String toString() {
    return 'TopArtistInfo(${[
      artistName,
      [listeners, playCount]
          .where((element) => element != null && element > 0)
          .join(', ')
    ].where((element) => element != null && element.isNotEmpty).join(', ')})';
  }
}
