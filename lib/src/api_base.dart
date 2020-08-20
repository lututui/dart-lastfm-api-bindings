import 'dart:convert';

import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/modules/album.dart';
import 'package:last_fm_api/src/modules/artist.dart';
import 'package:last_fm_api/src/modules/auth.dart';
import 'package:last_fm_api/src/modules/chart.dart';
import 'package:last_fm_api/src/modules/geo.dart';
import 'package:last_fm_api/src/modules/library.dart';
import 'package:last_fm_api/src/modules/tag.dart';
import 'package:last_fm_api/src/modules/track.dart';
import 'package:last_fm_api/src/modules/user.dart';
import 'package:meta/meta.dart';

const _kDefaultUserAgent = 'DartLastFMBindings/0.0.1';

class LastFM_API {
  factory LastFM_API(
    String apiKey, {
    String apiSecret,
    String userAgent = _kDefaultUserAgent,
    Duration rateLimit = const Duration(milliseconds: 100),
  }) {
    final client = LastFM_API_Client(
      apiKey,
      apiSecret: apiSecret,
      userAgent: userAgent,
      rateLimit: rateLimit,
    );

    return LastFM_API._(
      client,
      album: LastFM_Album(client),
      artist: LastFM_Artist(client),
      auth: LastFM_Auth(client),
      chart: LastFM_Chart(client),
      geo: LastFM_Geo(client),
      library: LastFM_Library(client),
      tag: LastFM_Tag(client),
      track: LastFM_Track(client),
      user: LastFM_User(client),
    );
  }

  const LastFM_API._(
    this._client, {
    @required this.album,
    @required this.artist,
    @required this.auth,
    @required this.chart,
    @required this.geo,
    @required this.library,
    @required this.tag,
    @required this.track,
    @required this.user,
  });

  final LastFM_API_Client _client;

  final LastFM_Album album;
  final LastFM_Artist artist;
  final LastFM_Auth auth;
  final LastFM_Chart chart;
  final LastFM_Geo geo;
  final LastFM_Library library;
  final LastFM_Tag tag;
  final LastFM_Track track;
  final LastFM_User user;

  static final Uri kRootApiUri = Uri.http(
    r'ws.audioscrobbler.com',
    '/2.0/',
    {'format': 'json'},
  );

  set sessionKey(String key) => _client.sessionKey = key;
}

bool parseBool(dynamic maybeBool) {
  if (maybeBool == null) return false;

  if (maybeBool is String) {
    return parseInt(maybeBool) == 1;
  } else if (maybeBool is Map<String, dynamic>) {
    return maybeBool.values.any((element) => element == '1');
  }

  throw FormatException(
    'Bool format not recognized: $maybeBool (${maybeBool.runtimeType})',
  );
}

int parseInt(dynamic maybeInt) {
  if (maybeInt == null) return 0;
  if (maybeInt is int) return maybeInt;
  if (maybeInt is String) {
    if (maybeInt == 'FIXME') return 0;

    return int.parse(maybeInt);
  }

  throw FormatException(
    'Int format not recognized: $maybeInt (${maybeInt.runtimeType})',
  );
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

Map<String, dynamic> buildSearchAttr(
  String methodName,
  Map<String, dynamic> data,
) {
  LastFmApiException.checkMissingKeys(
    methodName,
    ['opensearch:Query', 'opensearch:itemsPerPage', 'opensearch:totalResults'],
    data,
  );

  LastFmApiException.checkMissingKeys(
    methodName,
    ['startPage'],
    data['opensearch:Query'],
  );

  final perPage = parseInt(data['opensearch:itemsPerPage']);
  final total = parseInt(data['opensearch:totalResults']);

  return {
    'page': data['opensearch:Query']['startPage'],
    'perPage': perPage,
    'total': total,
    'totalPages': (total / perPage).ceil(),
  };
}

String boolToArgument(bool boolean) => boolean ?? false ? '1' : '0';