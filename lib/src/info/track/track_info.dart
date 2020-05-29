import 'package:last_fm_api/src/info/album/album_info.dart';
import 'package:last_fm_api/src/info/artist/artist_info.dart';
import 'package:last_fm_api/src/info/tag_info.dart';

class TrackInfo {
  final String trackId;
  final String trackName;
  final String mbid;
  final String url;
  final Duration duration;
  final bool streamable;
  final int listeners;
  final int playCount;
  final ArtistInfo trackArtist;
  final AlbumInfo trackAlbum;
  final List<TagInfo> trackTags;
  final String published;
  final String summary;
  final String content;

  TrackInfo({
    this.trackId,
    this.trackName,
    this.mbid,
    this.url,
    this.duration,
    this.streamable,
    this.listeners,
    this.playCount,
    this.trackArtist,
    this.trackAlbum,
    this.trackTags,
    this.published,
    this.summary,
    this.content,
  });

  @override
  String toString() => 'TrackInfo($trackName, ${trackArtist.artistName})';
}
