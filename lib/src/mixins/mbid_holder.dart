import 'package:last_fm_api/src/api_entity_info.dart';
import 'package:meta/meta.dart';

mixin MbidHolder on ApiEntityInfo {
  String get mbid;

  bool get hasMBID => mbid != null && mbid.isNotEmpty;

  @override
  @mustCallSuper
  Map<String, String> identify() {
    if (hasMBID) return {'mbid' : mbid};

    return null;
  }
}