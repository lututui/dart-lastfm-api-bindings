import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/lists/base_list.dart';

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
    List<String> sources,
  )   : assert(attributes != null),
        assert(sources != null),
        source = sources.map((e) {
          return '$e' +
              (attributes[e] == null ? '' : ': ${decodeString(attributes[e])}');
        }).join(', '),
        page = parseInt(attributes['page']),
        perPage = parseInt(attributes['perPage']),
        totalPages = parseInt(attributes['totalPages']),
        total = parseInt(attributes['total']),
        super(listData, listElementBuilder);

  @override
  String toFullString() => [source, super.toFullString()].join(', ');
}
