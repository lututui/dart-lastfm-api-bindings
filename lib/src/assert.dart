@pragma('vm:prefer-inline')
void assertString(String s) {
  assert(s != null && s.isNotEmpty);
}

@pragma('vm:prefer-inline')
void assertEitherOrStrings(List<String> either, String or) {
  assert(either.every((element) => element != null && element.isNotEmpty) ||
      (or != null && or.isNotEmpty));
}

@pragma('vm:prefer-inline')
void assertOptionalString(String optional) {
  assert(optional == null || optional.isNotEmpty);
}

@pragma('vm:prefer-inline')
void assertOptionalPositive(num d) {
  assert(d == null || d >= 1);
}
