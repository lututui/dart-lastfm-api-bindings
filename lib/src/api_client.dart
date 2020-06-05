import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/src/utils.dart' show mapToQuery;
import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/exception.dart';

class LastFM_API_Client extends BaseClient {
  final String _apiKey;
  final String _userAgent;
  final Duration _delay;
  final Queue<Completer> _requestQueue = Queue();
  final Client _internal;

  Timer _rateLimit;

  LastFM_API_Client(this._apiKey,
      [String userAgent, Duration betweenRequestsDelay])
      : _userAgent = userAgent ?? 'DartLastFMBindings/0.0.1',
        _delay = (betweenRequestsDelay ?? Duration.zero).inMilliseconds < 100
            ? const Duration(milliseconds: 100)
            : betweenRequestsDelay,
        _internal = Client() {
    assert(_userAgent.isNotEmpty);
  }

  Future<Map<String, dynamic>> buildAndGet(
    String methodName, {
    String rootTag,
    Map<String, String> args,
  }) {
    assert(methodName != null && methodName.isNotEmpty);

    return get(buildUri(methodName, args)).then(
      (response) => assertOk(response, methodName, rootTag?.toLowerCase()),
    );
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

  Map<String, dynamic> assertOk(
    Response response,
    String methodString, [
    String rootTag,
  ]) {
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
        'Map<String, dynamic>',
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

    if (rootTag == null || rootTag.isEmpty) {
      return mapResponse;
    }

    if (mapResponse[rootTag] == null) {
      throw ApiException.parsingMissingKey(
        methodString,
        rootTag,
        mapResponse.keys.toString(),
      );
    }

    return mapResponse[rootTag];
  }

  Future<StreamedResponse> _performSend(BaseRequest request) async {
    final completed = DateTime.now();
    print('Requesting ${request.hashCode.toRadixString(16)} at '
        '${completed.hour}:'
        '${completed.minute}:${completed.second}:${completed.millisecond}');

    return _internal.send(request..headers['user-agent'] = _userAgent);
  }

  void _onTimer(Timer timer) {
    if (_requestQueue.isEmpty) {
      print('Destroying client timer');
      timer.cancel();
      _rateLimit = null;
      return;
    }

    _requestQueue.removeFirst().complete();
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

  @override
  Future<Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final now = DateTime.now();
    final completer = Completer();

    print('Received request 0x${request.hashCode.toRadixString(16)} at '
        '${now.hour}:${now.minute}:${now.second}:${now.millisecond}');

    if (_rateLimit == null) {
      _rateLimit = Timer.periodic(_delay, _onTimer);

      return _performSend(request);
    }

    _requestQueue.add(completer);

    return completer.future.then((_) => _performSend(request));
  }
}
