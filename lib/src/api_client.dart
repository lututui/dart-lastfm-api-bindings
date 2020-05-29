import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/src/utils.dart' show mapToQuery;
import 'package:last_fm_api/last_fm_api.dart';
import 'package:last_fm_api/src/exception.dart';

class APIClient extends BaseClient {
  final String _apiKey;
  final String _userAgent;
  final Queue<Completer> _requestQueue = Queue();
  final Client _internal;

  Timer _rateLimit;

  APIClient(this._apiKey, [String userAgent])
      : _userAgent = userAgent ?? 'DartLastFMBindings/0.0.1',
        _internal = Client() {
    assert(_userAgent.isNotEmpty);
  }

  Uri buildUri(String method, [Map<String, String> args]) {
    assert(method != null && method.isNotEmpty);

    return LastFM_API.kRootApiUri.replace(
      query: mapToQuery(
        {
          ...?args,
          'method': method,
          'api_key': _apiKey,
          'format': 'json',
        }..removeWhere((key, value) => value == null),
        encoding: utf8,
      ),
    );
  }

  @override
  Future<Response> get(url, {Map<String, String> headers}) {
    assert(url is Uri);

    final uri = url as Uri;

    assert(uri.queryParameters['api_key'] == _apiKey);
    assert(uri.queryParameters['format'] == 'json');
    assert(uri.queryParameters['method'] != null);

    print('[API_Client] [GET] $uri');

    return super.get(uri, headers: headers);
  }

  Map<String, dynamic> assertOk(
    Response response,
    String methodString,
    String rootTag,
  ) {
    if (response.statusCode != 200) {
      throw ApiException.statusCode(
        methodString,
        response.statusCode,
        response.reasonPhrase,
      );
    }

    if (response.body == null || response.body.isEmpty) {
      throw ApiException.emptyBody(methodString);
    }

    final decodedBody = json.decode(response.body);

    if (decodedBody is! Map<String, dynamic>) {
      throw ApiException.wrongFormat(
        methodString,
        const <String, dynamic>{}.runtimeType.toString(),
        decodedBody.runtimeType.toString(),
      );
    }

    final mapResponse = decodedBody as Map<String, dynamic>;

    if (mapResponse['error'] != null) {
      throw ApiException.errorCode(
        methodString,
        mapResponse['error'],
        mapResponse['message'],
      );
    }

    if (mapResponse[rootTag] == null) {
      throw ApiException.parsingMissingKey(
        methodString,
        rootTag,
        '${mapResponse.keys.toList()}',
      );
    }

    return mapResponse[rootTag];
  }

  @override
  Future<Response> post(
    url, {
    Map<String, String> headers,
    body,
    Encoding encoding,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final now = DateTime.now();
    final completer = Completer();

    print(
      'Received request 0x${request.hashCode.toRadixString(16)} at '
      '${now.hour}:${now.minute}:${now.second}:${now.millisecond}',
    );

    if (_rateLimit == null) {
      _rateLimit = Timer.periodic(const Duration(milliseconds: 100), onTimer);

      return _performSend(request);
    }

    _requestQueue.add(completer);

    return completer.future.then((_) => _performSend(request));
  }

  Future<StreamedResponse> _performSend(BaseRequest request) async {
    final completed = DateTime.now();
    print('Requesting ${request.hashCode.toRadixString(16)} at '
        '${completed.hour}:'
        '${completed.minute}:${completed.second}:${completed.millisecond}');

    return _internal.send(request..headers['user-agent'] = _userAgent);
  }

  void onTimer(Timer timer) {
    if (_requestQueue.isEmpty) {
      print('Destroying client timer');
      timer.cancel();
      _rateLimit = null;
      return;
    }

    _requestQueue.removeFirst().complete();
  }
}
