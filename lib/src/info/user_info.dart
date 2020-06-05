import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/image.dart';

class UserInfo {
  final String userId;
  final String username;
  final String realName;
  final String userUrl;
  final ImageInfo userImages;
  final String country;
  final int age;
  final String gender;
  final int subscribers;
  final int playCount;
  final int playlists;
  final String bootstrap;
  final DateTime registered;

  UserInfo({
    this.userId,
    this.username,
    this.realName,
    this.userUrl,
    this.userImages,
    this.country,
    this.age,
    this.gender,
    this.subscribers,
    this.playCount,
    this.playlists,
    this.bootstrap,
    this.registered,
  });

  UserInfo.parse(Map<String, dynamic> data)
      : this(
          userId: data['id'],
          username: data['name'],
          realName: decodeString(data['realname']),
          userUrl: data['url'],
          userImages: ImageInfo.parse(data['image']),
          country: data['country'],
          age: parseInt(data['age']),
          gender: data['gender'],
          subscribers: parseInt(data['subscriber']),
          playCount: parseInt(data['playcount']),
          playlists: parseInt(data['playlists']),
          bootstrap: data['bootstrap'],
          registered: DateTime.fromMillisecondsSinceEpoch(
            parseInt(data['registered']['unixtime']) * 1000,
            isUtc: true,
          ),
        );

  @override
  String toString() {
    final info = [
      username,
      realName,
      country,
    ]
        .where((element) =>
            element != null &&
            element.isNotEmpty &&
            element.toLowerCase() != 'none')
        .join(', ');

    return 'UserInfo($info)';
  }
}
