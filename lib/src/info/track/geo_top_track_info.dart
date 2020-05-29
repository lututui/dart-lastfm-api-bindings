import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/info/artist/basic_artist_info.dart';
import 'package:last_fm_api/src/info/image.dart';
import 'package:last_fm_api/src/info/track/track_info.dart';

class GeoTopTrackInfo extends TrackInfo {
  final API_Images trackImages;

  GeoTopTrackInfo._(
    this.trackImages,
    String trackName,
    String mbid,
    String url,
    bool streamable,
    int listeners,
    Duration duration,
    BasicArtistInfo artistInfo,
  ) : super(
          trackName: trackName,
          mbid: mbid.isEmpty ? null : mbid,
          url: url,
          streamable: streamable,
          listeners: listeners,
          duration: duration == Duration.zero ? null : duration,
          trackArtist: artistInfo,
        );

  factory GeoTopTrackInfo(Map<String, dynamic> data) {
    return GeoTopTrackInfo._(
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
}
