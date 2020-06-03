class DateTimePeriod {
  final DateTime begin;
  final DateTime end;
  final Duration duration;

  DateTimePeriod(this.begin, this.end)
      : assert(begin != null),
        assert(end != null),
        assert(begin.isBefore(end)),
        duration = end.difference(begin);

  DateTimePeriod.parse(int begin, int end)
      : this(
          DateTime.fromMillisecondsSinceEpoch(begin * 1000, isUtc: true),
          DateTime.fromMillisecondsSinceEpoch(end * 1000, isUtc: true),
        );

  @override
  String toString() {
    if (duration.inDays > 0) {
      return 'DateTimePeriod(${[
        begin.toDateString(),
        end.toDateString(),
        '${duration.toDays.toStringAsFixed(2)} days'
      ].join(', ')})';
    }

    if (duration.inHours > 0) {
      return 'DateTimePeriod(${[
        '${begin.toDateString()} ${begin.toHourString()}',
        '${end.toDateString()} ${end.toHourString()}',
        '${duration.toHours.toStringAsFixed(2)} hours'
      ].join(', ')})';
    }

    if (duration.inMinutes > 0) {
      return 'DateTimePeriod(${[
        '${begin.toDateString()} ${begin.toHourString()}',
        '${end.toDateString()} ${end.toHourString()}',
        '${duration.toMinutes.toStringAsFixed(2)} minutes'
      ].join(', ')})';
    }

    return 'DateTimePeriod(${[
      '${begin.toDateString()} ${begin.toFullHourString()}',
      '${end.toDateString()} ${end.toFullHourString()}',
      '${duration.toSeconds.toStringAsFixed(2)} seconds'
    ].join(', ')})';
  }
}

extension _DurationDouble on Duration {
  double get toDays => inMicroseconds / Duration.microsecondsPerDay;

  double get toHours => inMicroseconds / Duration.microsecondsPerHour;

  double get toMinutes => inMicroseconds / Duration.microsecondsPerMinute;

  double get toSeconds => inMicroseconds / Duration.microsecondsPerSecond;
}

extension _DateTimeString on DateTime {
  String toDateString() {
    return [year, month, day]
        .map((e) => e.toString().padLeft(2, '0'))
        .join('-');
  }

  String toHourString() {
    return [hour, minute].map((e) => e.toString().padLeft(2, '0')).join(':');
  }

  String toFullHourString() {
    return [hour, minute, second, millisecond]
        .map((e) => e.toString().padLeft(2, '0'))
        .join(':');
  }
}
