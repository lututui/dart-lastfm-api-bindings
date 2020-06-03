import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/album/album_info.dart';
import 'package:last_fm_api/src/info/artist/basic_artist_info.dart';
import 'package:last_fm_api/src/info/image.dart';

class TopAlbumInfo extends AlbumInfo {
  final BasicArtistInfo artistInfo;

  TopAlbumInfo(
    String albumName,
    int playCount,
    String mbid,
    String url,
    this.artistInfo,
    ImageInfo images,
  ) : super(
          albumName: albumName,
          playCount: playCount,
          mbid: mbid,
          albumUrl: url,
          artistName: artistInfo.artistName,
          albumImages: images,
        );

  factory TopAlbumInfo.parse(Map<String, dynamic> data) {
    return TopAlbumInfo(
      decodeString(data['name']),
      parseInt(data['playcount']),
      data['mbid'],
      data['url'],
      BasicArtistInfo.parse(data['artist']),
      data['image'] != null ? ImageInfo.parse(data['image']) : null,
    );
  }
}
