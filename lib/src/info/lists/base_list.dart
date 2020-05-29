abstract class BaseList<T> {
  final List<T> elements;
  final int page;
  final int perPage;
  final int totalPages;
  final int total;

  BaseList(
    Map<String, dynamic> attributes,
    List<Map<String, dynamic>> listData,
    T Function(dynamic element) listElementBuilder,
  )   : elements = [for (final entry in listData) listElementBuilder(entry)],
        page = int.parse(attributes['page']),
        perPage = int.parse(attributes['perPage']),
        totalPages = int.parse(attributes['totalPages']),
        total = int.parse(attributes['total']);

  @override
  String toString() {
    throw UnsupportedError('$runtimeType failed to override toString method');
  }
}
