import 'dart:io';

import 'package:last_fm_api/last_fm_api.dart';

Future album(LastFM_API lastfm) async {
  return Future.wait([
    lastfm.album.getInfo(
      artistName: 'A Perfect Circle',
      albumName: 'Eat The Elephant',
    ),
    lastfm.album.getTags(
      'tutstutui',
      artistName: 'lady gaga',
      albumName: 'chromatica',
      autocorrect: true,
    ),
    lastfm.album.getTopTags(
      artistName: 'dorian electra',
      albumName: 'flamboyant',
      autocorrect: true,
    ),
    lastfm.album.search('one'),
  ]);
}

Future artist(LastFM_API lastfm) async {
  return Future.wait([
    lastfm.artist.getCorrection('florence and the machine'),
    lastfm.artist.getInfo(artistName: 'in this moment', autocorrect: true),
    lastfm.artist.getSimilar(artistName: 'arch enemy', autocorrect: true),
    lastfm.artist.getTags(
      'tutstutui',
      artistName: 'lady gaga',
      autocorrect: true,
    ),
    lastfm.artist.getTopAlbums('Lady Gaga'),
    lastfm.artist.getTopTags(artistName: 'poppy', autocorrect: true),
    lastfm.artist.getTopTracks(mbid: 'f59c5520-5f46-4d2c-b2c4-822eabf53419'),
    lastfm.artist.search('teeth'),
  ]);
}

Future chart(LastFM_API lastfm) async {
  return Future.wait([
    lastfm.chart.getTopArtists(),
    lastfm.chart.getTopTags(),
    lastfm.chart.getTopTracks(),
  ]);
}

Future geo(LastFM_API lastfm) async {
  return Future.wait([
    lastfm.geo.getTopArtists('Brazil'),
    lastfm.geo.getTopTracks('United States'),
  ]);
}

Future library(LastFM_API lastfm) async {
  return Future.wait([
    lastfm.library.getArtists('tutstutui'),
  ]);
}

Future tag(LastFM_API lastfm) async {
  return Future.wait([
    lastfm.tag.getInfo('pop'),
    lastfm.tag.getSimilar('pop'),
    lastfm.tag.getTopAlbums('indie'),
    lastfm.tag.getTopArtists('country'),
    lastfm.tag.getTopTags(),
    lastfm.tag.getTopTracks('loquendo'),
    lastfm.tag.getWeeklyChartList('metal'),
  ]);
}

Future track(LastFM_API lastfm) async {
  return Future.wait([
    lastfm.track.getCorrection('die kreatur', 'untergang'),
    lastfm.track.getInfo(
      artistName: 'poppy',
      trackName: 'bite your teeth',
      autocorrect: true,
    ),
    lastfm.track.getSimilar(
      artistName: 'lady gaga',
      trackName: 'bad romance',
      autocorrect: true,
    ),
    lastfm.track.getTags(
      'tutstutui',
      trackName: 'stupid love',
      artistName: 'lady gaga',
      autocorrect: true,
    ),
    lastfm.track.getTopTags(
      trackName: 'no tears left to cry',
      artistName: 'ariana grande',
      autocorrect: true,
    ),
    lastfm.track.search('rain'),
  ]);
}

Future user(LastFM_API lastfm) async {
  return Future.wait([
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
}

Future<void> main(List<String> args) async {
  if (args.isEmpty) return;

  final secret = {
    for (final e in await File('secret.yaml').readAsLines())
      if (!e.startsWith('#')) e.split(':')[0].trim(): e.split(':')[1].trim()
  };

  final lastfm = LastFM_API(secret['api_key'], apiSecret: secret['api_secret']);

  await lastfm.auth
      .getToken()
      .then((token) {
        print(lastfm.auth.buildAuthUrl(token));
        stdin.readLineSync();
        return token;
      })
      .then((token) => lastfm.auth.getSession(token))
      .then((session) => lastfm.sessionKey = session.sessionKey);

  final futures = <Future>[];

  for (final arg in args) {
    if (arg == 'album') {
      futures.add(album(lastfm));
    } else if (arg == 'artist') {
      futures.add(artist(lastfm));
    } else if (arg == 'chart') {
      futures.add(chart(lastfm));
    } else if (arg == 'geo') {
      futures.add(geo(lastfm));
    } else if (arg == 'library') {
      futures.add(library(lastfm));
    } else if (arg == 'tag') {
      futures.add(tag(lastfm));
    } else if (arg == 'track') {
      futures.add(track(lastfm));
    } else if (arg == 'user') {
      futures.add(user(lastfm));
    } else {
      throw UnsupportedError(arg);
    }
  }

  await Future.wait(futures)
      .then((value) => value.forEach((element) => element.forEach(print)));
}
