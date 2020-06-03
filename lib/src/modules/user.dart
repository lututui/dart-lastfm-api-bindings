import 'package:last_fm_api/datetime_period.dart';
import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/api_client.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/info/user_info.dart';
import 'package:last_fm_api/src/lists/albums_list.dart';
import 'package:last_fm_api/src/lists/artists_list.dart';
import 'package:last_fm_api/src/lists/base_list.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';
import 'package:last_fm_api/src/lists/users_list.dart';
import 'package:last_fm_api/src/period.dart';
import 'package:last_fm_api/src/tagging_type.dart';

class LastFM_User {
  final LastFM_API_Client _client;

  const LastFM_User(this._client);

  Future<UsersList> getFriends(
    String username, {
    @Deprecated('Unused') bool recentTracks,
    int limit,
    int page,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return UsersList(await _client.buildAndGet(
      'user.getFriends',
      'friends',
      {
        'user': username,
        'recenttracks': recentTracks ?? false ? '1' : '0',
        'limit': limit?.toString(),
        'page': page?.toString()
      },
    ));
  }

  Future<UserInfo> getInfo(String username) async {
    assert(username != null && username.isNotEmpty);

    return UserInfo.parse(
      await _client.buildAndGet('user.getInfo', 'user', {'user': username}),
    );
  }

  Future<TracksList> getLovedTracks(
    String username, {
    int limit,
    int page,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return TracksList.parse(
      await _client.buildAndGet(
        'user.getLovedTracks',
        'lovedTracks',
        {
          'user': username,
          'limit': limit?.toString(),
          'page': page?.toString()
        },
      ),
    );
  }

  Future<BaseList> getPersonalTags(
    String username,
    String tag,
    TaggingType taggingType, {
    int limit,
    int page,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert(tag != null && tag.isNotEmpty);
    assert(taggingType != null);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    final apiMethod = 'user.getPersonalTags';

    final queryResult = await _client.buildAndGet(apiMethod, 'taggings', {
      'user': username,
      'tag': tag,
      'taggingtype': taggingType.toString(),
      'limit': limit?.toString(),
      'page': page?.toString()
    });

    if (taggingType == TaggingType.album) {
      ApiException.checkMissingKey(apiMethod, 'albums', queryResult);

      return AlbumsList(
        {...queryResult['albums'], '@attr': queryResult['@attr']},
      );
    } else if (taggingType == TaggingType.artist) {
      ApiException.checkMissingKey(apiMethod, 'artists', queryResult);

      return ArtistsList(
        {...queryResult['artists'], '@attr': queryResult['@attr']},
      );
    } else if (taggingType == TaggingType.track) {
      ApiException.checkMissingKey(apiMethod, 'tracks', queryResult);

      return TracksList.parse(
        {...queryResult['tracks'], '@attr': queryResult['@attr']},
      );
    }

    throw UnsupportedError('Unsupported tagging type: $taggingType');
  }

  Future<TracksList> getRecentTracks(
    String username, {
    int limit,
    int page,
    bool extended,
    DateTime from,
    DateTime to,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);
    assert(from == null || to == null || from.isBefore(to));

    return TracksList.parse(await _client.buildAndGet(
      'user.getRecentTracks',
      'recentTracks',
      {
        'user': username,
        'limit': limit?.toString(),
        'page': page?.toString(),
        'from': from?.secondsSinceEpoch?.toString(),
        'to': to?.secondsSinceEpoch?.toString(),
        'extended': extended ?? false ? '1' : '0'
      },
    ));
  }

  Future<AlbumsList> getTopAlbums(
    String username, {
    LastFM_Period period,
    int limit,
    int page,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return AlbumsList(
      await _client.buildAndGet('user.getTopAlbums', 'topAlbums', {
        'user': username,
        'period': period?.toString(),
        'limit': limit?.toString(),
        'page': page?.toString()
      }),
    );
  }

  Future<ArtistsList> getTopArtists(
    String username, {
    LastFM_Period period,
    int limit,
    int page,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return ArtistsList(await _client.buildAndGet(
      'user.getTopArtists',
      'topArtists',
      {
        'user': username,
        'period': period?.toString(),
        'limit': limit?.toString(),
        'page': page?.toString()
      },
    ));
  }

  Future<TagsList> getTopTags(String username, {int limit}) async {
    assert(username != null && username.isNotEmpty);
    assert(limit == null || limit >= 1);

    return TagsList.parse(await _client.buildAndGet(
      'user.getTopTags',
      'topTags',
      {'user': username, 'limit': limit?.toString()},
    ));
  }

  Future<TracksList> getTopTracks(
    String username, {
    LastFM_Period period,
    int limit,
    int page,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert(limit == null || limit >= 1);
    assert(page == null || page >= 1);

    return TracksList.parse(
      await _client.buildAndGet('user.getTopTracks', 'topTracks', {
        'user': username,
        'period': period?.toString(),
        'limit': limit?.toString(),
        'page': page?.toString()
      }),
    );
  }

  Future<AlbumsList> getWeeklyAlbumChart(
    String username, {
    DateTime from,
    DateTime to,
    DateTimePeriod period,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert((from == null && to == null) || period == null);

    return AlbumsList(await _client.buildAndGet(
      'user.getWeeklyAlbumChart',
      'weeklyAlbumChart',
      {
        'user': username,
        'from': from?.secondsSinceEpoch?.toString() ??
            period?.begin?.secondsSinceEpoch?.toString(),
        'to': to?.secondsSinceEpoch?.toString() ??
            period?.end?.secondsSinceEpoch?.toString(),
      },
    ));
  }

  Future<ArtistsList> getWeeklyArtistChart(
    String username, {
    DateTime from,
    DateTime to,
    DateTimePeriod period,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert((from == null && to == null) || period == null);

    return ArtistsList(await _client.buildAndGet(
      'user.getWeeklyArtistChart',
      'weeklyArtistChart',
      {
        'user': username,
        'from': from?.secondsSinceEpoch?.toString() ??
            period?.begin?.secondsSinceEpoch?.toString(),
        'to': to?.secondsSinceEpoch?.toString() ??
            period?.end?.secondsSinceEpoch?.toString(),
      },
    ));
  }

  Future<List<DateTimePeriod>> getWeeklyChartList(String username) async {
    assert(username != null && username.isNotEmpty);

    final queryResult = ((await _client.buildAndGet(
      'user.getWeeklyChartList',
      'weeklyChartList',
      {'user': username},
    ))['chart'] as List)
        .cast<Map<String, dynamic>>();

    return [
      for (final entry in queryResult)
        DateTimePeriod(
          DateTime.fromMillisecondsSinceEpoch(
            parseInt(entry['from']) * 1000,
            isUtc: true,
          ),
          DateTime.fromMillisecondsSinceEpoch(
            parseInt(entry['to']) * 1000,
            isUtc: true,
          ),
        )
    ];
  }

  Future<TracksList> getWeeklyTrackChart(
    String username, {
    DateTime from,
    DateTime to,
    DateTimePeriod period,
  }) async {
    assert(username != null && username.isNotEmpty);
    assert((from == null && to == null) || period == null);

    return TracksList.parse(await _client.buildAndGet(
      'user.getWeeklyTrackChart',
      'weeklyTrackChart',
      {
        'user': username,
        'from': from?.secondsSinceEpoch?.toString() ??
            period?.begin?.secondsSinceEpoch?.toString(),
        'to': to?.secondsSinceEpoch?.toString() ??
            period?.end?.secondsSinceEpoch?.toString(),
      },
    ));
  }
}

extension _SecondsSinceEpoch on DateTime {
  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;
}
