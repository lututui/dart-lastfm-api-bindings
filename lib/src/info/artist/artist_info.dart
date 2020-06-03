import 'package:last_fm_api/src/info/image.dart';
import 'package:last_fm_api/src/info/tag_info.dart';

class ArtistInfo {
  final String artistName;
  final String mbid;
  final String artistUrl;
  final ImageInfo artistImages;
  final bool streamable;
  final int listeners;
  final int playCount;
  final List<ArtistInfo> similarArtists;
  final List<TagInfo> tags;
  final String published;
  final String summary;
  final String bio;

  ArtistInfo({
    this.artistName,
    this.mbid,
    this.artistUrl,
    this.artistImages,
    this.streamable,
    this.listeners,
    this.playCount,
    this.similarArtists,
    this.tags,
    this.published,
    this.summary,
    this.bio,
  });
}
