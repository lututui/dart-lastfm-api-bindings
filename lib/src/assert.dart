@pragma('vm:prefer-inline')
@deprecated
void assertString(String s) {
  assert(s != null && s.isNotEmpty);
}

@pragma('vm:prefer-inline')
@deprecated
void assertEitherOrStrings(List<String> either, String or) {
  assert(either.every((element) => element != null && element.isNotEmpty) ||
      (or != null && or.isNotEmpty));
}

@pragma('vm:prefer-inline')
@deprecated
void assertOptionalString(String optional) {
  assert(optional == null || optional.isNotEmpty);
}

@pragma('vm:prefer-inline')
@deprecated
void assertOptionalPositive(num d) {
  assert(d == null || d >= 1);
}
