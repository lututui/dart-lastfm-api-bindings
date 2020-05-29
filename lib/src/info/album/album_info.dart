import 'package:last_fm_api/src/info/image.dart';
import 'package:last_fm_api/src/info/tag_info.dart';
import 'package:last_fm_api/src/info/track/track_info.dart';

class AlbumInfo {
  final String albumName;
  final String artistName;
  final String albumId;
  final String mbid;
  final String albumUrl;
  final String releaseDate;
  final API_Images albumImages;
  final int listeners;
  final int playCount;
  final List<TagInfo> tags;
  final List<TrackInfo> tracks;

  const AlbumInfo(
      {this.albumName,
      this.artistName,
      this.albumId,
      this.mbid,
      this.albumUrl,
      this.releaseDate,
      this.albumImages,
      this.listeners,
      this.playCount,
      this.tags,
      this.tracks});

  @override
  String toString() {
    return 'AlbumInfo($albumName, $artistName)';
  }
}
