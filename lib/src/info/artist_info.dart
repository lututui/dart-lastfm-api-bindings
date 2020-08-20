import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/api_entity_info.dart';
import 'package:last_fm_api/src/info/image.dart';
import 'package:last_fm_api/src/lists/artists_list.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:last_fm_api/src/mixins/mbid_holder.dart';

class ArtistInfo extends ApiEntityInfo with MbidHolder {
  final String artistName;
  final String mbid;
  final String artistUrl;
  final ImageInfo artistImages;
  final bool streamable;
  final int listeners;
  final int playCount;
  final ArtistsList similarArtists;
  final TagsList tags;
  final String published;
  final String summary;
  final String bio;

  ArtistInfo(
    this.artistName, {
    this.mbid,
    this.artistUrl,
    this.artistImages,
    this.streamable,
    this.listeners,
    this.playCount,
    this.similarArtists,
    this.tags,
    this.published,
    this.summary,
    this.bio,
  }) : assert(artistName != null && artistName.isNotEmpty);

  factory ArtistInfo.parse(dynamic data) {
    if (data == null) return null;

    if (data is String) return ArtistInfo(data);

    final wiki = data['wiki'] ?? const {};

    return ArtistInfo(
      decodeString(data['name'] ?? data['#text']),
      mbid: data['mbid'],
      artistUrl: data['url'],
      artistImages: ImageInfo.parse(data['image']),
      streamable: parseBool(data['streamable']),
      listeners: parseInt(data['listeners']),
      playCount: parseInt(data['playcount']),
      similarArtists: data['similarArtists'],
      tags: TagsList.parse(data['tags']),
      published: wiki['published'],
      summary: wiki['summary'],
      bio: wiki['bio'],
    );
  }

  @override
  Map<String, String> identify() {
    return super.identify() ?? {'artist': artistName};
  }

  @override
  String toString() {
    return 'ArtistInfo(${[
      artistName,
      [listeners, playCount]
          .where((element) => element != null && element > 0)
          .join(', ')
    ].where((element) => element != null && element.isNotEmpty).join(', ')})';
  }
}
