class LastFM_Album {
  Future addTags(
    String artistName,
    String albumName,
    List<String> tags,
  ) {
    throw UnimplementedError();
  }

  Future getInfo(
    String artistName,
    String albumName, [
    String mbid,
    bool autocorrect,
    String usernamePlayCount,
    String lang,
  ]) {
    throw UnimplementedError();
  }

  Future getTags(
    String artistName,
    String albumName, [
    String mbid,
    bool autocorrect,
    String usernamePlayCount,
  ]) {
    throw UnimplementedError();
  }

  Future getTopTags(
    String artistName,
    String albumName, [
    String mbid,
    bool autocorrect,
  ]) {
    throw UnimplementedError();
  }

  /// Auth required
  Future removeTag(String artistName, String albumName, String tagName) {
    throw UnimplementedError();
  }

  Future search(String albumName, [int limit, int page]) {
    throw UnimplementedError();
  }
}
