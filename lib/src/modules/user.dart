class LastFM_User {
  Future getFriends(String username, [bool recentTracks, int limit, int page]) {
    throw UnimplementedError();
  }

  Future getInfo(String username) {
    throw UnimplementedError();
  }

  Future getLovedTracks(String username, [int limit, int page]) {
    throw UnimplementedError();
  }

  Future getPersonalTags(String username, String tag, String taggingType,
      [int limit, int page]) {
    throw UnimplementedError();
  }

  Future getRecentTags(String username,
      [int limit,
      int page,
      int fromTimestamp,
      bool extended,
      int toTimestamp]) {
    throw UnimplementedError();
  }

  Future getTopAlbums(String username, [String period, int limit, int page]) {
    throw UnimplementedError();
  }

  Future getTopArtists(String username, [String period, int limit, int page]) {
    throw UnimplementedError();
  }

  Future getTopTags(String username, [int limit]) {
    throw UnimplementedError();
  }

  Future getTopTracks(String username, [String period, int limit, int page]) {
    throw UnimplementedError();
  }

  Future getWeeklyAlbumChart(String username, [String from, String to]) {
    throw UnimplementedError();
  }

  Future getWeeklyArtistChart(String username, [String from, String to]) {
    throw UnimplementedError();
  }

  Future getWeeklyChartList(String username) {
    throw UnimplementedError();
  }

  Future getWeeklyTrackChart(String username, [String from, String to]) {
    throw UnimplementedError();
  }
}
