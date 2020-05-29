import 'package:last_fm_api/src/info/image.dart';

class LastFM_UserInfo {
  final String userId;
  final String username;
  final String realName;
  final String userUrl;
  final API_Images userImages;
  final String country;
  final String age;
  final String gender;
  final int subscribers;
  final int playCount;
  final int playlists;
  final String bootstrap;
  final String registered;

  LastFM_UserInfo(
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
      this.registered);
}
