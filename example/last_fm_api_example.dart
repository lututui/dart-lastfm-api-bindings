import 'dart:io';

import 'package:last_fm_api/last_fm_api.dart';

Future<void> main() async {
  final readLines = File('secret.yaml').readAsLinesSync();
  final secret = {
    for (final e in readLines)
      if (!e.startsWith('#')) e.split(':')[0].trim(): e.split(':')[1].trim()
  };

  final lastfm = LastFM_API(secret['api_key']);

  await Future.wait([
    lastfm.geo.getTopArtists('Brazil', limit: 5),
    lastfm.geo.getTopTracks('United States', limit: 1),
    lastfm.chart.getTopArtists(limit: 2),
    lastfm.chart.getTopTags(limit: 2),
    lastfm.chart.getTopTracks(limit: 2),
  ]).then((value) => value.forEach(print));
}
