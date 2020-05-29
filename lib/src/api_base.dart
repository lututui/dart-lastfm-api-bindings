import 'dart:convert';

import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/modules/chart.dart';
import 'package:last_fm_api/src/modules/geo.dart';

class LastFM_API {
  factory LastFM_API(String apiKey, [String userAgent]) {
    final client = APIClient(apiKey, userAgent);

    return LastFM_API._(
      geo: LastFM_Geo(client),
      chart: LastFM_Chart(client),
    );
  }

  const LastFM_API._({this.geo, this.chart});

  final LastFM_Geo geo;
  final LastFM_Chart chart;

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
