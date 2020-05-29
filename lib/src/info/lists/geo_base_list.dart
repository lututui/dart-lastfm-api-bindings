import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/lists/base_list.dart';

abstract class GeoBaseList<T> extends BaseList<T> {
  final String country;

  GeoBaseList(
    Map<String, dynamic> attributes,
    List<Map<String, dynamic>> listData,
    T Function(dynamic element) listElementBuilder,
  )   : country = decodeString(attributes['country']),
        super(attributes, listData, listElementBuilder);
}
