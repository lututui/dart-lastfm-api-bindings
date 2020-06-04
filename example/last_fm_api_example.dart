import 'dart:io';
import 'dart:math';

import 'package:last_fm_api/last_fm_api.dart';

Future<void> main() async {
  final readLines = File('secret.yaml').readAsLinesSync();
  final secret = {
    for (final e in readLines)
      if (!e.startsWith('#')) e.split(':')[0].trim(): e.split(':')[1].trim()
  };

  final lastfm = LastFM_API(secret['api_key']);

  final modules = {
    'album': await Future.wait([
      lastfm.album.getInfo('A Perfect Circle', 'Eat The Elephant'),
    ]),
    'artist': await Future.wait([
      lastfm.artist.getTopTracks(artistName: 'Beyoncé', autocorrect: true),
      lastfm.artist.getTopTracks(mbid: 'f59c5520-5f46-4d2c-b2c4-822eabf53419'),
      lastfm.artist.getTopAlbums('Lady Gaga'),
    ]),
    //'auth' : auth,
    'chart': await Future.wait([
      lastfm.chart.getTopArtists(),
      lastfm.chart.getTopTags(),
      lastfm.chart.getTopTracks(),
    ]),
    'geo': await Future.wait([
      lastfm.geo.getTopArtists('Brazil'),
      lastfm.geo.getTopTracks('United States'),
    ]),
    'library': await Future.wait([
      lastfm.library.getArtists('tutstutui'),
    ]),
    'tag': await Future.wait([
      lastfm.tag.getTopTracks('loquendo'),
      lastfm.tag.getTopAlbums('indie'),
      lastfm.tag.getInfo('pop'),
      lastfm.tag.getSimilar('pop'),
      lastfm.tag.getTopArtists('country'),
      lastfm.tag.getTopTags(),
      lastfm.tag.getWeeklyChartList('metal'),
    ]),
    //'track' : track,
    'user': await Future.wait([
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
    ]),
  };

  final moduleTitleLength = 2 * modules.keys.map((e) => e.length).reduce(max);

  for (final entry in modules.entries) {
    print(entry.key
        .toUpperCase()
        .padLeft((moduleTitleLength + entry.key.length) ~/ 2, '=')
        .padRight(moduleTitleLength, '='));
    entry.value.forEach(print);
  }
}
