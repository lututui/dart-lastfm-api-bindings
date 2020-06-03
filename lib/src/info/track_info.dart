import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/album_info.dart';
import 'package:last_fm_api/src/info/artist_info.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';

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
  final TagsList trackTags;
  final String published;
  final String summary;
  final String content;

  TrackInfo(
    this.trackName, {
    this.trackId,
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
  }) : assert(trackName != null && trackName.isNotEmpty);

  factory TrackInfo.parse(Map<String, dynamic> data) {
    final wiki = data['wiki'] ?? const {};

    return TrackInfo(
      decodeString(data['name']),
      trackId: data['id'],
      mbid: data['mbid'],
      url: data['url'],
      duration: Duration(seconds: parseInt(data['duration'])),
      streamable: parseStreamable(data['streamable']),
      listeners: parseInt(data['listeners']),
      playCount: parseInt(data['playcount']),
      trackArtist: ArtistInfo.parse(data['artist']),
      trackAlbum: AlbumInfo.parse(data['album']),
      trackTags: TagsList.parse(data['tags']),
      published: wiki['published'],
      summary: wiki['summary'],
      content: wiki['content'],
    );
  }

  @override
  String toString() => 'TrackInfo($trackName, ${trackArtist.artistName})';
}
