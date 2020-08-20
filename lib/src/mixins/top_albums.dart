import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/api_entity_info.dart';
import 'package:last_fm_api/src/api_module.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/lists/albums_list.dart';

mixin TopAlbums<T extends ApiEntityInfo> on ApiModule {
  Future<AlbumsList> getTopAlbums(
    covariant T entity, {
    bool autocorrect = true,
    int page = 1,
    int limit = 50,
  }) async {
    LastFmApiException.checkPositive(page);
    LastFmApiException.checkPositive(limit);

    return AlbumsList.parse(await client.buildAndSubmit(
      '$prefix.getTopAlbums',
      rootTag: 'topAlbums',
      args: {
        ...entity.identify(),
        'autocorrect': boolToArgument(autocorrect),
        'page': '$page',
        'limit': '$limit'
      },
    ));
  }
}
