import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/api_entity_info.dart';
import 'package:last_fm_api/src/info/artist_info.dart';
import 'package:last_fm_api/src/info/image.dart';
import 'package:last_fm_api/src/lists/tags_list.dart';
import 'package:last_fm_api/src/lists/tracks_list.dart';
import 'package:last_fm_api/src/mixins/mbid_holder.dart';

class AlbumInfo extends ApiEntityInfo with MbidHolder {
  final String albumName;
  final ArtistInfo artist;
  final String albumId;
  final String albumUrl;
  final String releaseDate;
  final ImageInfo albumImages;
  final int listeners;
  final int playCount;
  final TagsList tags;
  final TracksList tracks;

  @override
  final String mbid;

  String get artistName => artist.artistName;

  AlbumInfo(
    this.albumName,
    this.artist, {
    this.albumId,
    this.mbid,
    this.albumUrl,
    this.releaseDate,
    this.albumImages,
    this.listeners,
    this.playCount,
    this.tags,
    this.tracks,
  })  : assert(albumName != null && albumName.isNotEmpty),
        assert(artist != null);

  factory AlbumInfo.parse(Map<String, dynamic> data) {
    if (data == null) return null;

    final artistName = (data['name'] ?? data['#text']) as String;

    if (artistName == null || artistName.isEmpty) return null;

    return AlbumInfo(
      decodeString(artistName),
      ArtistInfo.parse(data['artist']),
      albumId: data['id'],
      mbid: data['mbid'],
      albumUrl: data['url'],
      releaseDate: data['releasedate'],
      albumImages: ImageInfo.parse(data['image']),
      listeners: parseInt(data['listeners']),
      playCount: parseInt(data['playcount']),
      tags: TagsList.parse(data['tags']),
      tracks: TracksList.parse(data['tracks']),
    );
  }

  @override
  Map<String, String> identify() {
    return super.identify() ?? {'album': albumName, 'artist': artistName};
  }

  @override
  String toString() {
    if (tracks == null || tracks.isEmpty) {
      return 'AlbumInfo($albumName, $artist)';
    }

    return 'AlbumInfo($albumName, $artist, ${tracks.toShortString()}})';
  }
}
