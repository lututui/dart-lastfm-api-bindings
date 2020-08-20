import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:http/src/utils.dart' show mapToQuery;
import 'package:last_fm_api/src/api_base.dart';
import 'package:last_fm_api/src/exception.dart';
import 'package:meta/meta.dart';

class LastFM_API_Client extends BaseClient {
  final String apiKey;
  final String _apiSecret;

  final String _userAgent;
  final Duration _rateLimit;

  final Queue<Completer> _requestQueue = Queue();
  final Client _internal = Client();

  Timer _queueTimer;
  String _sessionKey;

  LastFM_API_Client(
    this.apiKey, {
    String apiSecret,
    String sessionKey,
    @required String userAgent,
    @required Duration rateLimit,
  })  : assert(userAgent != null && userAgent.isNotEmpty),
        assert(rateLimit != null),
        _apiSecret = apiSecret,
        _sessionKey = sessionKey,
        _userAgent = userAgent,
        _rateLimit = rateLimit;

  set sessionKey(String value) => _sessionKey = value;

  bool get isAuth => _sessionKey != null && _sessionKey.isNotEmpty;

  Future<Map<String, dynamic>> buildAndSubmit(
    String methodName, {
    String rootTag,
    Map<String, String> args,
    bool forcePost = false,
  }) {
    assert(methodName != null && methodName.isNotEmpty);

    final mapData = {
      ...?args,
      'method': methodName,
      'api_key': apiKey,
      if (isAuth) 'sk': _sessionKey,
    }..removeWhere((key, value) => value == null);

    if (forcePost || isAuth) {
      return post(LastFM_API.kRootApiUri, body: signBody(mapData)).then(
        (response) => assertOk(response, methodName, rootTag?.toLowerCase()),
      );
    }

    return get(
      LastFM_API.kRootApiUri.replace(
        query: mapToQuery(
          {...LastFM_API.kRootApiUri.queryParameters, ...mapData},
          encoding: utf8,
        ),
      ),
    ).then(
      (response) => assertOk(response, methodName, rootTag?.toLowerCase()),
    );
  }

  Map<String, String> signBody(Map<String, String> preBody) {
    assert(_apiSecret != null && _apiSecret.isNotEmpty);

    final bodyKeys = List.of(preBody.keys)..sort();
    final signatureBuilder = StringBuffer();

    for (final key in bodyKeys) {
      signatureBuilder.write('$key${preBody[key]}');
    }

    signatureBuilder.write(_apiSecret);

    final sigStr = signatureBuilder.toString();

    return {
      ...preBody,
      'api_sig': md5.convert(utf8.encode(sigStr)).toString(),
    };
  }

  Map<String, dynamic> assertOk(
    Response response,
    String methodString, [
    String rootTag,
  ]) {
    if (response.statusCode != 200) {
      throw LastFmApiException.statusCode(
        methodString,
        response.statusCode,
        response.reasonPhrase,
      );
    }

    if (response.body == null || response.body.isEmpty) {
      throw LastFmApiException.emptyBody(methodString);
    }

    final decodedBody = json.decode(response.body);

    if (decodedBody is! Map<String, dynamic>) {
      throw LastFmApiException.wrongFormat(
        methodString,
        'Map<String, dynamic>',
        decodedBody.runtimeType.toString(),
      );
    }

    final mapResponse = decodedBody as Map<String, dynamic>;

    if (mapResponse['error'] != null) {
      throw LastFmApiException.errorCode(
        methodString,
        mapResponse['error'],
        mapResponse['message'],
      );
    }

    if (rootTag == null || rootTag.isEmpty) {
      return mapResponse;
    }

    LastFmApiException.checkMissingKeys(methodString, [rootTag], mapResponse);

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
      _queueTimer = null;
      return;
    }

    _requestQueue.removeFirst().complete();
  }

  @override
  Future<Response> get(dynamic url, {Map<String, String> headers}) {
    assert(url is Uri);

    final uri = url as Uri;

    assert(uri.queryParameters['api_key'] == apiKey);
    assert(uri.queryParameters['format'] == 'json');
    assert(uri.queryParameters['method'] != null);

    print('[API_Client] [GET] $uri');

    return super.get(uri, headers: headers);
  }

  @override
  Future<Response> post(
    dynamic url, {
    Map<String, String> headers,
    dynamic body,
    Encoding encoding,
  }) {
    assert(url is Uri);
    assert(body is Map<String, String>);

    final uri = (url as Uri).replace(scheme: 'https');
    final mapBody = body as Map<String, String>;

    assert(uri.queryParameters['format'] == 'json');
    assert(mapBody['api_key'] == apiKey);
    assert(mapBody['method'] != null);
    assert(mapBody['api_sig'] != null);

    print('[API_Client] [POST] ${mapBody['method']}');

    return super.post(
      uri,
      headers: headers,
      body: mapBody,
      encoding: encoding ?? utf8,
    );
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final now = DateTime.now();
    final completer = Completer();

    print('Received request 0x${request.hashCode.toRadixString(16)} at '
        '${now.hour}:${now.minute}:${now.second}:${now.millisecond}');

    if (_queueTimer == null) {
      _queueTimer = Timer.periodic(_rateLimit, _onTimer);

      return _performSend(request);
    }

    _requestQueue.add(completer);

    return completer.future.then((_) => _performSend(request));
  }
}
