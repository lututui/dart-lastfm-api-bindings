import 'package:last_fm_api/src/info/user_info.dart';
import 'package:last_fm_api/src/lists/base_top_list.dart';

class UsersList extends BaseTopList<UserInfo> {
  UsersList(Map<String, dynamic> data)
      : super(
          data['@attr'],
          (data['user'] as List).cast<Map<String, dynamic>>(),
          (element) => UserInfo.parse(element),
          ['friends'],
        );
}
