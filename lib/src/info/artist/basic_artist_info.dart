import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/info/artist/artist_info.dart';

class BasicArtistInfo extends ArtistInfo {
  BasicArtistInfo._(String artistName, String mbid, String artistUrl)
      : super(artistName: artistName, mbid: mbid, artistUrl: artistUrl);

  factory BasicArtistInfo(Map<String, dynamic> data) {
    return BasicArtistInfo._(
        decodeString(data['name']), data['mbid'], data['url']);
  }
}
