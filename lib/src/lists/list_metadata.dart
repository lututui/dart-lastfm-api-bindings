import 'package:last_fm_api/datetime_period.dart';
import 'package:last_fm_api/last_fm_api.dart';

class ListMetadata {
  final int page;
  final int perPage;
  final int totalPages;
  final int total;
  final String country;
  final String artist;
  final String tag;
  final String user;
  final String album;
  final DateTimePeriod dateTimePeriod;

  const ListMetadata(
    this.page,
    this.perPage,
    this.totalPages,
    this.total, {
    this.country,
    this.artist,
    this.tag,
    this.user,
        this.album,
    this.dateTimePeriod,
  })  : assert(page != null),
        assert(perPage != null),
        assert(totalPages != null),
        assert(total != null);

  factory ListMetadata.parse(Map<String, dynamic> data) {
    if (data == null) return null;

    final country = decodeString(data['country']);
    final artist = decodeString(data['artist']);
    final tag = decodeString(data['tag']);
    final user = decodeString(data['user']);
    final album = decodeString(data['album']);
    final dateTimePeriod = DateTimePeriod.parse(
      parseInt(data['from']),
      parseInt(data['to']),
    );

    return ListMetadata(
      parseInt(data['page']),
      parseInt(data['perPage']),
      parseInt(data['totalPages']),
      parseInt(data['total']),
      country: country,
      artist: artist,
      tag: tag,
      user: user,
      album: album,
      dateTimePeriod: dateTimePeriod,
    );
  }

  @override
  String toString() {
    return ({
      'country': country,
      'artist': artist,
      'tag': tag,
      'user': user,
      'period': dateTimePeriod
    }..removeWhere((key, value) => value == null || value.toString().isEmpty))
        .entries
        .map((e) => '${e.key}: ${e.value}')
        .join(', ');
  }
}
