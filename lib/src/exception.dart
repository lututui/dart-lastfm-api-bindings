class ApiException implements Exception {
  final String reason;

  const ApiException(this.reason);

  const factory ApiException.errorCode(
    String apiMethod,
    int errorCode,
    String errorString,
  ) = ApiErrorCodeException;

  const factory ApiException.statusCode(
    String apiMethod,
    int statusCode,
    String statusCodeString,
  ) = ApiErrorCodeException.http;

  const factory ApiException.emptyBody(String apiMethod) =
      ApiFormatException.empty;

  const factory ApiException.wrongFormat(
    String apiMethod,
    String expected,
    String got,
  ) = ApiFormatException;

  const factory ApiException.parsingMissingKey(
    String apiMethod,
    String missing,
    String keyPool,
  ) = ApiFormatException.missing;

  static void checkMissingKeys(
    String apiMethod,
    List<String> mustContain,
    Map<String, dynamic> data,
  ) {
    for (final key in mustContain) {
      if (data[key] != null) continue;

      throw ApiException.parsingMissingKey(
        apiMethod,
        key,
        data.keys.toString(),
      );
    }
  }

  @override
  String toString() => 'APIException: $reason';
}

class ApiErrorCodeException extends ApiException {
  const ApiErrorCodeException(
    String apiMethod,
    int errorCode,
    String errorString,
  ) : super('Calling $apiMethod returned error code $errorCode: $errorString');

  const ApiErrorCodeException.http(
    String apiMethod,
    int errorCode,
    String errorString,
  ) : super('Calling $apiMethod returned http code $errorCode: $errorString');
}

class ApiFormatException extends ApiException {
  const ApiFormatException(
    String apiMethod,
    String expected,
    String got,
  ) : super('Calling $apiMethod returned $got instead of $expected');

  const ApiFormatException.empty(String apiMethod)
      : super('Calling $apiMethod returned an empty response body');

  const ApiFormatException.missing(
    String apiMethod,
    String missing,
    String pool,
  ) : super('Calling $apiMethod returned a body missing key a element: '
            '$missing. All elements: $pool');
}
