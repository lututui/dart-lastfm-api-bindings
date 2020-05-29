import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/info/artist/basic_artist_info.dart';
import 'package:last_fm_api/src/info/image.dart';

class TopTrackInfo {
  final API_Images trackImages;
  final String trackName;
  final String mbid;
  final String url;
  final bool streamable;
  final int listeners;
  final Duration duration;
  final BasicArtistInfo trackArtist;

  TopTrackInfo._(
    this.trackImages,
    this.trackName,
    this.mbid,
    this.url,
    this.streamable,
    this.listeners,
    this.duration,
    this.trackArtist,
  );

  factory TopTrackInfo(Map<String, dynamic> data) {
    return TopTrackInfo._(
      API_Images((data['image'] as List).cast<Map<String, dynamic>>()),
      decodeString(data['name']),
      data['mbid'],
      data['url'],
      parseStreamable(data['streamable']),
      int.parse(data['listeners']),
      Duration(seconds: int.parse(data['duration'])),
      BasicArtistInfo(data['artist']),
    );
  }

  @override
  String toString() {
    return 'TopTrackInfo($trackName, ${trackArtist.artistName}, '
        '${listeners ?? 0})';
  }
}
