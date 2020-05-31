import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/info/lists/base_list.dart';

abstract class BaseTopList<T> extends BaseList<T> {
  final String source;
  final int page;
  final int perPage;
  final int totalPages;
  final int total;

  BaseTopList(
    Map<String, dynamic> attributes,
    List<Map<String, dynamic>> listData,
    T Function(dynamic element) listElementBuilder,
    String sourceType,
  )   : assert(attributes != null),
        assert(sourceType != null),
        source = '$sourceType' +
            (attributes[sourceType] == null
                ? ''
                : ': ${decodeString(attributes[sourceType])}'),
        page = parseInt(attributes['page']),
        perPage = parseInt(attributes['perPage']),
        totalPages = parseInt(attributes['totalPages']),
        total = parseInt(attributes['total']),
        super(listData, listElementBuilder);

  @override
  String toFullString() => [source, super.toFullString()].join(', ');
}
