class LastFM_Track {
  Future addTags(String artistName, String trackName, List<String> tags) {
    throw UnimplementedError();
  }

  Future getCorrection(String artistName, String trackName) {
    throw UnimplementedError();
  }

  Future getInfo(
    String artistName,
    String trackName, [
    String mbid,
    String usernamePlayCount,
    bool autocorrect,
  ]) {
    throw UnimplementedError();
  }

  Future getSimilar(
    String artistName,
    String trackName, [
    String mbid,
    bool autocorrect,
    int limit,
  ]) {
    throw UnimplementedError();
  }

  Future getTags(String artistName, String trackName,
      [String mbid, bool autocorrect, String user]) {
    throw UnimplementedError();
  }

  Future getTopTags(String artistName, String trackName,
      [String mbid, bool autocorrect]) {
    throw UnimplementedError();
  }

  Future love(String artistName, String trackName) {
    throw UnimplementedError();
  }

  Future removeTag(String artistName, String trackName, String tagName) {
    throw UnimplementedError();
  }

  Future scrobble(Map<String, Map<String, String>> scrobbleInfo) {
    throw UnimplementedError();
  }

  Future search(String trackName, [String artistName, int page, int limit]) {
    throw UnimplementedError();
  }

  Future unLove(String artistName, String trackName) {
    throw UnimplementedError();
  }

  Future updateNowPlaying(
    String artistName,
    String trackName, [
    String albumName,
    int trackNumber,
    String mbid,
    String duration,
    String albumArtist,
  ]) {
    throw UnimplementedError();
  }
}
