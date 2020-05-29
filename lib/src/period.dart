class LastFM_Period {
  final String period;

  const LastFM_Period._(this.period);

  @override
  String toString() => period;

  static const LastFM_Period overall = LastFM_Period._('overall');
  static const LastFM_Period week = LastFM_Period._('7day');
  static const LastFM_Period month = LastFM_Period._('1month');
  static const LastFM_Period trimester = LastFM_Period._('3month');
  static const LastFM_Period semester = LastFM_Period._('6month');
  static const LastFM_Period year = LastFM_Period._('12month');
}
