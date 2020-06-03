import 'dart:io';

import 'package:last_fm_api/last_fm_api.dart';

Future<void> main() async {
  final readLines = File('secret.yaml').readAsLinesSync();
  final secret = {
    for (final e in readLines)
      if (!e.startsWith('#')) e.split(':')[0].trim(): e.split(':')[1].trim()
  };

  final lastfm = LastFM_API(secret['api_key']);

  final album = await Future.wait([
    lastfm.album.getInfo('A Perfect Circle', 'Eat The Elephant'),
  ]);

  final artist = await Future.wait([
    lastfm.artist.getTopTracks(artistName: 'Beyoncé', autocorrect: true),
    lastfm.artist.getTopTracks(mbid: 'f59c5520-5f46-4d2c-b2c4-822eabf53419'),
    lastfm.artist.getTopAlbums('Lady Gaga'),
  ]).then((list) => list.map((e) => e.toString()).toList());

  //final auth = [];

  final chart = await Future.wait([
    lastfm.chart.getTopArtists(),
    lastfm.chart.getTopTags(),
    lastfm.chart.getTopTracks(),
  ]).then((list) => list.map((e) => e.toString()).toList());

  final geo = await Future.wait([
    lastfm.geo.getTopArtists('Brazil'),
    lastfm.geo.getTopTracks('United States'),
  ]).then((list) => list.map((e) => e.toString()).toList());

  //final library = [];
  final tag = await Future.wait([
    lastfm.tag.getTopTracks('loquendo'),
    lastfm.tag.getTopAlbums('indie'),
  ]);
  //final track = [];
  final user = await Future.wait([
    lastfm.user.getInfo('tutstutui'),
    lastfm.user.getFriends('tutstutui'),
    lastfm.user.getLovedTracks('tutstutui'),
    lastfm.user.getPersonalTags('tutstutui', 'lg6', TaggingType.album),
    lastfm.user.getRecentTracks('tutstutui'),
    lastfm.user.getRecentTracks(
      'tutstutui',
      to: DateTime.now().subtract(const Duration(days: 5)),
    ),
    lastfm.user.getTopTracks('tutstutui', period: LastFM_Period.trimester),
    lastfm.user.getTopAlbums('tutstutui', period: LastFM_Period.semester),
    lastfm.user.getTopArtists('tutstutui', period: LastFM_Period.week),
    lastfm.user.getTopTags('tutstutui'),
    lastfm.user.getWeeklyChartList('tutstutui'),
    lastfm.user.getWeeklyAlbumChart('tutstutui'),
    lastfm.user.getWeeklyArtistChart('tutstutui'),
    lastfm.user.getWeeklyTrackChart('tutstutui'),
  ]);

  print('====ALBUM====');
  album.forEach(print);
  print('============');

  print('===ARTIST===');
  artist.forEach(print);
  print('============');

  print('===CHART===');
  chart.forEach(print);
  print('===========');

  print('====GEO====');
  geo.forEach(print);
  print('===========');

  print('====TAG====');
  tag.forEach(print);
  print('===========');

  print('====USER====');
  user.forEach(print);
  print('============');
}
