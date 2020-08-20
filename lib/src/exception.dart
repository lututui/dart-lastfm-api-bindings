import 'package:last_fm_api/src/api_client.dart';

abstract class LastFmApiException implements Exception {
  final String reason;

  const LastFmApiException(this.reason);

  const factory LastFmApiException.errorCode(
    String apiMethod,
    int errorCode,
    String errorString,
  ) = ErrorCodeException;

  const factory LastFmApiException.statusCode(
    String apiMethod,
    int statusCode,
    String statusCodeString,
  ) = ErrorCodeException.http;

  const factory LastFmApiException.emptyBody(String apiMethod) =
      ResponseFormatException.empty;

  const factory LastFmApiException.wrongFormat(
    String apiMethod,
    String expected,
    String got,
  ) = ResponseFormatException;

  static void checkMissingKeys(
    String apiMethod,
    List<String> mustContain,
    Map<String, dynamic> data,
  ) {
    for (final key in mustContain) {
      if (data[key] != null) continue;

      throw ResponseFormatException.missing(
        apiMethod,
        key,
        data.keys.toString(),
      );
    }
  }

  static void checkAuthenticated(LastFM_API_Client client) {
    if (client.isAuth) return;

    throw AuthenticationException(client.hashCode);
  }

  static void checkNotNullOrEmpty(String s, [String name]) {
    if (s == null) throw ArgumentError.notNull(name);
    if (s.isEmpty) throw ArgumentError.value(s, name, 'Must not be empty');
  }

  static void checkPositive(num d, [String name]) {
    if (d == null) throw ArgumentError.notNull(name);
    if (d <= 0) throw ArgumentError.value(d, name, 'Must be positive');
  }

  @override
  String toString() => 'APIException: $reason';
}

class ErrorCodeException extends LastFmApiException {
  const ErrorCodeException(
    String apiMethod,
    int errorCode,
    String errorString,
  ) : super('Calling $apiMethod returned error code $errorCode: $errorString');

  const ErrorCodeException.http(
    String apiMethod,
    int errorCode,
    String errorString,
  ) : super('Calling $apiMethod returned http code $errorCode: $errorString');
}

class ResponseFormatException extends LastFmApiException {
  const ResponseFormatException(
    String apiMethod,
    String expected,
    String got,
  ) : super('Calling $apiMethod returned $got instead of $expected');

  const ResponseFormatException.empty(String apiMethod)
      : super('Calling $apiMethod returned an empty response body');

  const ResponseFormatException.missing(
    String apiMethod,
    String missing,
    String pool,
  ) : super('Calling $apiMethod returned a body missing key a element: '
            '$missing. All elements: $pool');
}

class AuthenticationException extends LastFmApiException {
  AuthenticationException(int hashCode)
      : super(
          'The client instance with hash code 0x${hashCode.toRadixString(16)} '
          'is not authenticated and cannot perform the requested operation',
        );
}
