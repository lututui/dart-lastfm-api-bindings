class LastFM_Artist {
  /// Requires auth
  Future addTags(String artistName, List<String> tags) {
    throw UnimplementedError();
  }

  Future getCorrection(String artistName) {
    throw UnimplementedError();
  }

  Future getInfo(
    String artistName, [
    String mbid,
    String lang,
    bool autocorrect,
    String usernamePlayCount,
  ]) {
    throw UnimplementedError();
  }

  Future getSimilar(
    String artistName, [
    String mbid,
    int limit,
    bool autocorrect,
  ]) {
    throw UnimplementedError();
  }

  Future getTags(
    String artistName, [
    String mbid,
    String username,
    bool autocorrect,
  ]) {
    throw UnimplementedError();
  }

  Future getTopAlbums(
    String artistName, [
    String mbid,
    bool autocorrect,
    int page,
    int limit,
  ]) {
    throw UnimplementedError();
  }

  Future getTopTags(String artistName, [String mbid, bool autocorrect]) {
    throw UnimplementedError();
  }

  Future getTopTracks(
    String artistName, [
    String mbid,
    bool autocorrect,
    int page,
    int limit,
  ]) {
    throw UnimplementedError();
  }

  /// Requires auth
  Future removeTag(String artistName, String tag) {
    throw UnimplementedError();
  }

  Future search(String artistName, [int limit, int page]) {
    throw UnimplementedError();
  }
}
