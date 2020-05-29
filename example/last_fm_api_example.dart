import 'dart:io';

import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/period.dart';

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
    lastfm.artist
        .getTopTracks(artistName: 'Beyoncé', autocorrect: true, limit: 2),
    lastfm.artist
        .getTopTracks(mbid: 'f59c5520-5f46-4d2c-b2c4-822eabf53419', limit: 3),
    lastfm.tag.getTopTracks('loquendo', limit: 4),
    lastfm.user
        .getTopTracks('tutstutui', period: LastFM_Period.trimester, limit: 1),
    lastfm.artist.getTopAlbums('Lady Gaga', limit: 3),
    lastfm.tag.getTopAlbums('indie', limit: 5),
  ]).then((value) => value.forEach(print));
}
