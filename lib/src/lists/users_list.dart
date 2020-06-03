import 'package:last_fm_api/src/info/user_info.dart';
import 'package:last_fm_api/src/lists/base_list.dart';
import 'package:last_fm_api/src/lists/list_metadata.dart';

class UsersList extends BaseList<UserInfo> {
  UsersList(Map<String, dynamic> data)
      : super(
          (data['user'] as List).cast<Map<String, dynamic>>(),
          (element) => UserInfo.parse(element),
          ListMetadata.parse(data['@attr']),
        );
}
