import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/artist/basic_artist_info.dart';
import 'package:last_fm_api/src/info/image.dart';
import 'package:last_fm_api/src/info/track/track_info.dart';

class TopTrackInfo extends TrackInfo {
  final ImageInfo trackImages;

  TopTrackInfo._(
    this.trackImages,
    String trackName,
    String mbid,
    String url,
    bool streamable,
    int listeners,
    int playCount,
    Duration duration,
    BasicArtistInfo artistInfo,
  ) : super(
          trackName: trackName,
          mbid: mbid?.isEmpty ?? true ? null : mbid,
          url: url,
          streamable: streamable,
          listeners: listeners,
          duration: duration == Duration.zero ? null : duration,
          trackArtist: artistInfo,
          playCount: playCount,
        );

  factory TopTrackInfo(Map<String, dynamic> data) {
    return TopTrackInfo._(
      ImageInfo.parse(data['image']),
      decodeString(data['name']),
      data['mbid'],
      data['url'],
      parseStreamable(data['streamable']),
      parseInt(data['listeners']),
      parseInt(data['playcount']),
      Duration(seconds: parseInt(data['duration'])),
      BasicArtistInfo.parse(data['artist']),
    );
  }
}
