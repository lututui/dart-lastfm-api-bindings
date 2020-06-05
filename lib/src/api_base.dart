import 'dart:convert';

import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/modules/album.dart';
import 'package:last_fm_api/src/modules/artist.dart';
import 'package:last_fm_api/src/modules/chart.dart';
import 'package:last_fm_api/src/modules/geo.dart';
import 'package:last_fm_api/src/modules/library.dart';
import 'package:last_fm_api/src/modules/tag.dart';
import 'package:last_fm_api/src/modules/track.dart';
import 'package:last_fm_api/src/modules/user.dart';

class LastFM_API {
  factory LastFM_API(
    String apiKey, [
    String userAgent,
    Duration betweenRequestsDelay,
  ]) {
    final client = LastFM_API_Client(apiKey, userAgent, betweenRequestsDelay);

    return LastFM_API._(
      album: LastFM_Album(client),
      artist: LastFM_Artist(client),
      chart: LastFM_Chart(client),
      geo: LastFM_Geo(client),
      library: LastFM_Library(client),
      tag: LastFM_Tag(client),
      track: LastFM_Track(client),
      user: LastFM_User(client),
    );
  }

  const LastFM_API._({
    this.album,
    this.artist,
    this.chart,
    this.geo,
    this.library,
    this.tag,
    this.track,
    this.user,
  });

  final LastFM_Album album;
  final LastFM_Artist artist;
  final LastFM_Chart chart;
  final LastFM_Geo geo;
  final LastFM_Library library;
  final LastFM_Tag tag;
  final LastFM_Track track;
  final LastFM_User user;

  static final Uri kRootApiUri = Uri.http(r'ws.audioscrobbler.com', '/2.0/');
}

bool parseStreamable(streamable) {
  if (streamable == null) return false;

  if (streamable is String) {
    return parseInt(streamable) == 1;
  } else if (streamable is Map<String, dynamic>) {
    return streamable.values.any((element) => element == '1');
  }

  throw FormatException('Streamable format not recognized: '
      '${streamable.runtimeType}');
}

int parseInt(maybeInt) {
  if (maybeInt == null) return 0;
  if (maybeInt is int) return maybeInt;
  if (maybeInt is String) {
    if (maybeInt == 'FIXME') return 0;

    return int.parse(maybeInt);
  }

  throw FormatException();
}

String decodeString(String target) {
  if (target == null) return null;
  if (target.isEmpty) return '';

  try {
    return utf8.decode(target.codeUnits);
  } on FormatException {
    return target;
  }
}
