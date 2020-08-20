import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/api_entity_info.dart';
import 'package:last_fm_api/src/api_module.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';

mixin TopTracks<T extends ApiEntityInfo> on ApiModule {
  Future<TracksList> getTopTracks(
    covariant T entity, {
    bool autocorrect = true,
    int page = 1,
    int limit = 50,
  }) async {
    LastFmApiException.checkPositive(page);
    LastFmApiException.checkPositive(limit);

    return TracksList.parse(await client.buildAndSubmit(
      '$prefix.getTopTracks',
      rootTag: 'topTracks',
      args: {
        ...entity.identify(),
        'autocorrect': boolToArgument(autocorrect),
        'page': '$page',
        'limit': '$limit'
      },
    ));
  }
}
