import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/album/album_info.dart';
import 'package:last_fm_api/src/info/artist/basic_artist_info.dart';
import 'package:last_fm_api/src/info/image.dart';

class TopAlbumInfo extends AlbumInfo {
  final BasicArtistInfo artistInfo;

  TopAlbumInfo._(String albumName, int playCount, String mbid, String url,
      this.artistInfo, API_Images images)
      : super(
            albumName: albumName,
            playCount: playCount,
            mbid: mbid,
            albumUrl: url,
            artistName: artistInfo.artistName,
            albumImages: images);

  factory TopAlbumInfo(Map<String, dynamic> data) {
    return TopAlbumInfo._(
        decodeString(data['name']),
        data['playcount'],
        data['mbid'],
        data['url'],
        BasicArtistInfo(data['artist']),
        API_Images((data['image'] as List).cast<Map<String, dynamic>>()));
  }
}
