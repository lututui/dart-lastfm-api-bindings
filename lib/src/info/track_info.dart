import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/album_info.dart';
import 'package:last_fm_api/src/info/artist_info.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:meta/meta.dart';
import 'package:timeago/timeago.dart';

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
  final bool nowPlaying;
  final DateTime scrobbleDate;

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
    @required this.nowPlaying,
    this.scrobbleDate,
  })  : assert(trackName != null && trackName.isNotEmpty),
        assert(nowPlaying != null);

  factory TrackInfo.parse(Map<String, dynamic> data) {
    final wiki = data['wiki'] ?? const {};
    final metadata = data['@attr'] ?? const {};
    final scrobbledDate = (data['date'] ?? const {})['uts'];

    return TrackInfo(
      decodeString(data['name']),
      trackId: data['id'],
      mbid: data['mbid'],
      url: data['url'],
      duration: Duration(seconds: parseInt(data['duration'])),
      streamable: parseBool(data['streamable']),
      listeners: parseInt(data['listeners']),
      playCount: parseInt(data['playcount']),
      trackArtist: ArtistInfo.parse(data['artist']),
      trackAlbum: AlbumInfo.parse(data['album']),
      trackTags: TagsList.parse(data['tags']),
      published: wiki['published'],
      summary: wiki['summary'],
      content: wiki['content'],
      nowPlaying: metadata['nowplaying'] == 'true',
      scrobbleDate: scrobbledDate != null
          ? DateTime.fromMillisecondsSinceEpoch(parseInt(scrobbledDate) * 1000)
          : null,
    );
  }

  @override
  String toString() {
    if (nowPlaying) {
      return 'TrackInfo(${[
        trackName,
        trackArtist?.artistName,
        'playing now'
      ].join(', ')})';
    }

    if (scrobbleDate != null) {
      return 'TrackInfo(${[
        trackName,
        trackArtist?.artistName,
        'scrobbled ${format(scrobbleDate.toLocal())}'
      ].join(', ')})';
    }

    return 'TrackInfo(${[trackName, trackArtist?.artistName].join(', ')})';
  }
}
