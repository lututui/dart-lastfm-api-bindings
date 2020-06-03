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
    lastfm.artist.getTopTracks(
      artistName: 'Beyoncé',
      autocorrect: true,
      limit: 2,
    ),
    lastfm.artist.getTopTracks(
      mbid: 'f59c5520-5f46-4d2c-b2c4-822eabf53419',
      limit: 3,
    ),
    lastfm.tag.getTopTracks('loquendo', limit: 4),
    lastfm.user.getTopTracks(
      'tutstutui',
      period: LastFM_Period.trimester,
      limit: 1,
    ),
    lastfm.artist.getTopAlbums('Lady Gaga', limit: 3),
    lastfm.tag.getTopAlbums('indie', limit: 5),
    lastfm.user.getTopAlbums(
      'tutstutui',
      period: LastFM_Period.semester,
      limit: 2,
    ),
    lastfm.album.getInfo('A Perfect Circle', 'Eat The Elephant'),
    lastfm.user.getInfo('tutstutui'),
    lastfm.user.getFriends('tutstutui'),
    lastfm.user.getLovedTracks('tutstutui'),
    lastfm.user.getPersonalTags('tutstutui', 'lg6', TaggingType.album),
    lastfm.user.getRecentTracks('tutstutui', limit: 3),
    lastfm.user.getRecentTracks(
      'tutstutui',
      limit: 3,
      to: DateTime.now().subtract(Duration(days: 5)),
    ),
    lastfm.user.getTopArtists(
      'tutstutui',
      period: LastFM_Period.week,
      limit: 5,
    ),
    lastfm.user.getTopTags('tutstutui'),
    lastfm.user.getWeeklyChartList('tutstutui'),
    lastfm.user.getWeeklyAlbumChart('tutstutui'),
    lastfm.user.getWeeklyArtistChart('tutstutui'),
    lastfm.user.getWeeklyTrackChart('tutstutui'),
  ]).then((value) => value.forEach(print));
}
