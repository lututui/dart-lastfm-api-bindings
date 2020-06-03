import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/artist/artist_info.dart';

class BasicArtistInfo extends ArtistInfo {
  BasicArtistInfo(String artistName, String mbid, String artistUrl)
      : super(artistName: artistName, mbid: mbid, artistUrl: artistUrl);

  factory BasicArtistInfo.parse(Map<String, dynamic> data) {
    if (data['name'] != null) {
      return BasicArtistInfo(
        decodeString(data['name']),
        data['mbid'],
        data['url'],
      );
    } else if (data['#text'] != null) {
      return BasicArtistInfo(decodeString(data['#text']), data['mbid'], null);
    }

    throw FormatException();
  }
}
