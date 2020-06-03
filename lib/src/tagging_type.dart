class TaggingType {
  final String type;
  final List<String> tags;

  const TaggingType._(this.type, this.tags);

  @override
  String toString() => type;

  static const TaggingType artist = TaggingType._('artist', ['user', 'tag', 'artists']);
  static const TaggingType album = TaggingType._('album', ['user', 'tag', 'albums']);
  static const TaggingType track = TaggingType._('track', ['user', 'tag', 'tracks']);
}
