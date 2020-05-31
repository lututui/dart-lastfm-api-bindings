import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/info/album/album_info.dart';
import 'package:last_fm_api/src/info/artist/artist_info.dart';
import 'package:last_fm_api/src/info/artist/basic_artist_info.dart';
import 'package:last_fm_api/src/info/lists/tags_list.dart';

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

  factory TrackInfo.parse(Map<String, dynamic> data) {
    final wiki = data['wiki'] ?? const {};

    return TrackInfo(
      trackId: data['id'],
      trackName: decodeString(data['name']),
      mbid: data['mbid'],
      url: data['url'],
      duration: Duration(seconds: parseInt(data['duration'])),
      streamable: parseStreamable(data['streamable']),
      listeners: parseInt(data['listeners']),
      playCount: parseInt(data['playcount']),
      trackArtist: BasicArtistInfo(data['artist']),
      trackAlbum: data['album'] != null ? AlbumInfo.parse(data['album']) : null,
      trackTags: data['tags'] != null ? TagsList(data['tags']) : null,
      published: wiki['published'],
      summary: wiki['summary'],
      content: wiki['content'],
    );
  }

  @override
  String toString() => 'TrackInfo($trackName, ${trackArtist.artistName})';
}
