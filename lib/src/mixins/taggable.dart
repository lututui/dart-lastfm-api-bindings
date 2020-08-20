import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/api_entity_info.dart';
import 'package:last_fm_api/src/api_module.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';

mixin Taggable<T extends ApiEntityInfo> on ApiModule {
  /// Get the tags applied by an user.
  ///
  /// Returns a [TagsList] with the tags applied by an individual [user] to an
  /// [entity] on Last.fm.
  ///
  /// {@macro LastFmApi.autocorrect_template}
  ///
  /// {@macro LastFmApi.no_auth_template}
  Future<TagsList> getTags(
    String user,
    covariant T entity, {
    bool autocorrect = true,
  }) async {
    final methodName = '$prefix.getTags';
    const rootTagName = 'tags';

    LastFmApiException.checkNotNullOrEmpty(user, 'user');
    ArgumentError.checkNotNull(entity);

    return TagsList.parse(await client.buildAndSubmit(
      methodName,
      rootTag: rootTagName,
      args: {
        ...entity.identify(),
        'user': user,
        'autocorrect': boolToArgument(autocorrect),
      },
    ));
  }

  /// Get the top tags.
  ///
  /// Returns a [TagsList] for an [entity] on Last.fm, ordered by popularity.
  ///
  /// {@macro LastFmApi.autocorrect_template}
  ///
  /// {@macro LastFmApi.no_auth_template}
  Future<TagsList> getTopTags(
    covariant T entity, {
    bool autocorrect = true,
  }) async {
    final methodName = '$prefix.getTopTags';
    const rootTagName = 'topTags';

    ArgumentError.checkNotNull(entity);

    return TagsList.parse(await client.buildAndSubmit(
      methodName,
      rootTag: rootTagName,
      args: {...entity.identify(), 'autocorrect': boolToArgument(autocorrect)},
    ));
  }

  /// Add user tags.
  ///
  /// The [tags] list must contain at least one tag and at most 10.
  ///
  /// {@template LastFmApi.requires_auth_template}
  /// This service requires authentication.
  /// {@category Authenticated}
  /// {@endtemplate}
  Future<bool> addTags(covariant T entity, List<String> tags) async {
    final methodName = '$prefix.addTags';

    LastFmApiException.checkAuthenticated(client);
    RangeError.checkValueInInterval(tags.length, 1, 10, 'amount of tags');

    for (final tag in tags) {
      LastFmApiException.checkNotNullOrEmpty(tag, 'tag');
    }

    return client.buildAndSubmit(methodName, args: {
      ...entity.identify(),
      'tags': tags.join(',')
    }).then((value) => value.isEmpty);
  }

  /// Remove an user tag.
  ///
  /// {@macro LastFmApi.requires_auth_template}
  Future<bool> removeTag(covariant T entity, String tagName) async {
    final methodName = '$prefix.removeTag';

    LastFmApiException.checkAuthenticated(client);
    LastFmApiException.checkNotNullOrEmpty(tagName, 'tag');

    return client.buildAndSubmit(methodName, args: {
      ...entity.identify(),
      'tag': tagName
    }).then((value) => value.isEmpty);
  }
}
