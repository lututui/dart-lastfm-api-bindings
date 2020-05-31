import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/image.dart';
import 'package:last_fm_api/src/info/lists/tags_list.dart';
import 'package:last_fm_api/src/info/lists/track_list.dart';

class AlbumInfo {
  final String albumName;
  final String artistName;
  final String albumId;
  final String mbid;
  final String albumUrl;
  final String releaseDate;
  final API_Images albumImages;
  final int listeners;
  final int playCount;
  final TagsList tags;
  final TrackList tracks;

  const AlbumInfo({
    this.albumName,
    this.artistName,
    this.albumId,
    this.mbid,
    this.albumUrl,
    this.releaseDate,
    this.albumImages,
    this.listeners,
    this.playCount,
    this.tags,
    this.tracks,
  });

  AlbumInfo.parse(Map<String, dynamic> data)
      : this(
          albumName: decodeString(data['name']),
          artistName: decodeString(data['artist']),
          albumId: data['id'],
          mbid: data['mbid'],
          albumUrl: data['url'],
          releaseDate: data['releasedate'],
          albumImages: API_Images(data['image']),
          listeners: parseInt(data['listeners']),
          playCount: parseInt(data['playcount']),
          tags: TagsList(data['tags']),
          tracks: TrackList(data['tracks']),
        );

  @override
  String toString() {
    if (tracks == null || tracks.isEmpty) {
      return 'AlbumInfo($albumName, $artistName)';
    }

    return 'AlbumInfo($albumName, $artistName, ${tracks.toShortString()}})';
  }
}
