import 'package:last_fm_api/last_fm_api.dart';

class ScrobbleInfo {
  final bool wasArtistCorrected;
  final String artistName;

  final bool wasAlbumCorrected;
  final String albumName;

  final bool wasAlbumArtistCorrected;
  final String albumArtist;

  final bool wasTrackCorrected;
  final String trackName;

  final int ignoredCode;
  final String ignoredReason;

  final DateTime timestamp;

  bool get wasIgnored => ignoredCode != 0;

  const ScrobbleInfo(
    this.wasArtistCorrected,
    this.artistName,
    this.wasAlbumCorrected,
    this.albumName,
    this.wasAlbumArtistCorrected,
    this.albumArtist,
    this.wasTrackCorrected,
    this.trackName,
    this.ignoredCode,
    this.ignoredReason,
    this.timestamp,
  );

  factory ScrobbleInfo.parse(Map<String, dynamic> data) {
    final timestamp = data['timestamp'];

    return ScrobbleInfo(
      parseBool(data['artist']['corrected']),
      decodeString(data['artist']['#text']),
      parseBool(data['album']['corrected']),
      decodeString(data['album']['#text']),
      parseBool(data['albumArtist']['corrected']),
      decodeString(data['albumArtist']['#text']),
      parseBool(data['track']['corrected']),
      decodeString(data['track']['#text']),
      parseInt(data['ignoredMessage']['code']),
      decodeString(data['ignoredMessage']['#text']),
      timestamp != null
          ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
          : null,
    );
  }

  @override
  String toString() {
    if (wasIgnored) {
      return 'NowPlayingInfo(ignored with code: $ignoredCode)';
    }

    return 'NowPlayingInfo($trackName, $artistName)';
  }
}
