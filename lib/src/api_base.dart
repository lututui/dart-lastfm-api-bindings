import 'dart:convert';

import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/modules/artist.dart';
import 'package:last_fm_api/src/modules/chart.dart';
import 'package:last_fm_api/src/modules/geo.dart';
import 'package:last_fm_api/src/modules/tag.dart';
import 'package:last_fm_api/src/modules/user.dart';

class LastFM_API {
  factory LastFM_API(String apiKey,
      [String userAgent, Duration betweenRequestsDelay]) {
    final client = LastFM_API_Client(apiKey, userAgent, betweenRequestsDelay);

    return LastFM_API._(
      artist: LastFM_Artist(client),
      chart: LastFM_Chart(client),
      geo: LastFM_Geo(client),
      tag: LastFM_Tag(client),
      user: LastFM_User(client),
    );
  }

  const LastFM_API._({this.artist, this.chart, this.geo, this.tag, this.user});

  final LastFM_Artist artist;
  final LastFM_Chart chart;
  final LastFM_Geo geo;
  final LastFM_Tag tag;
  final LastFM_User user;

  static final Uri kRootApiUri = Uri.http(r'ws.audioscrobbler.com', '/2.0/');
}

bool parseStreamable(streamable) {
  if (streamable == null) return false;

  if (streamable is String) {
    return streamable == '1';
  } else if (streamable is Map<String, dynamic>) {
    return streamable.values.any((element) => element == '1');
  }

  throw FormatException('Streamable format not recognized: '
      '${streamable.runtimeType}');
}

String decodeString(String target) => utf8.decode(target.codeUnits);
