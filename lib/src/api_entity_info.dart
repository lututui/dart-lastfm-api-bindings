abstract class ApiEntityInfo {
  const ApiEntityInfo();

  Map<String, String> identify();

  @override
  String toString() {
    throw UnsupportedError('$runtimeType failed to implement toString');
  }
}
