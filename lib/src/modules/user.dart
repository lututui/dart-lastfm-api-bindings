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

    return UsersList(await _client.buildAndSubmit(
      'user.getFriends',
      rootTag: 'friends',
      args: {
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
      await _client.buildAndSubmit(
        'user.getInfo',
        rootTag: 'user',
        args: {'user': username},
      ),
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
      await _client.buildAndSubmit(
        'user.getLovedTracks',
        rootTag: 'lovedTracks',
        args: {
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

    const apiMethod = 'user.getPersonalTags';

    final queryResult = await _client.buildAndSubmit(
      apiMethod,
      rootTag: 'taggings',
      args: {
        'user': username,
        'tag': tag,
        'taggingtype': taggingType.toString(),
        'limit': limit?.toString(),
        'page': page?.toString()
      },
    );

    if (taggingType == TaggingType.album) {
      ApiException.checkMissingKeys(apiMethod, ['albums'], queryResult);

      return AlbumsList.parse(
        {...queryResult['albums'], '@attr': queryResult['@attr']},
      );
    } else if (taggingType == TaggingType.artist) {
      ApiException.checkMissingKeys(apiMethod, ['artists'], queryResult);

      return ArtistsList.parse(
        {...queryResult['artists'], '@attr': queryResult['@attr']},
      );
    } else if (taggingType == TaggingType.track) {
      ApiException.checkMissingKeys(apiMethod, ['tracks'], queryResult);

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

    return TracksList.parse(await _client.buildAndSubmit(
      'user.getRecentTracks',
      rootTag: 'recentTracks',
      args: {
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

    return AlbumsList.parse(
      await _client
          .buildAndSubmit('user.getTopAlbums', rootTag: 'topAlbums', args: {
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

    return ArtistsList.parse(await _client.buildAndSubmit(
      'user.getTopArtists',
      rootTag: 'topArtists',
      args: {
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

    return TagsList.parse(await _client.buildAndSubmit(
      'user.getTopTags',
      rootTag: 'topTags',
      args: {'user': username, 'limit': limit?.toString()},
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
      await _client.buildAndSubmit(
        'user.getTopTracks',
        rootTag: 'topTracks',
        args: {
          'user': username,
          'period': period?.toString(),
          'limit': limit?.toString(),
          'page': page?.toString()
        },
      ),
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

    return AlbumsList.parse(await _client.buildAndSubmit(
      'user.getWeeklyAlbumChart',
      rootTag: 'weeklyAlbumChart',
      args: {
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

    return ArtistsList.parse(await _client.buildAndSubmit(
      'user.getWeeklyArtistChart',
      rootTag: 'weeklyArtistChart',
      args: {
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

    final queryResult = ((await _client.buildAndSubmit(
      'user.getWeeklyChartList',
      rootTag: 'weeklyChartList',
      args: {'user': username},
    ))['chart'] as List)
        .cast<Map<String, dynamic>>();

    return [
      for (final entry in queryResult)
        DateTimePeriod.parse(parseInt(entry['from']), parseInt(entry['to']))
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

    return TracksList.parse(await _client.buildAndSubmit(
      'user.getWeeklyTrackChart',
      rootTag: 'weeklyTrackChart',
      args: {
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
