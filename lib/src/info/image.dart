class API_Images {
  final _SizedImage small;
  final _SizedImage medium;
  final _SizedImage large;
  final _SizedImage extralarge;
  final _SizedImage mega;

  API_Images._(
    this.small,
    this.medium,
    this.large,
    this.extralarge,
    this.mega,
  );

  factory API_Images(List<dynamic> data) {
    final castedList = data.cast<Map<String, dynamic>>();

    final images = {
      for (final entry in castedList)
        entry['size']: _SizedImage(entry['size'], entry['#text'])
    };

    return API_Images._(
      images['small'],
      images['medium'],
      images['large'],
      images['extralarge'],
      images['mega'],
    );
  }
}

class _SizedImage {
  final String sizeString;
  final String url;

  _SizedImage(this.sizeString, this.url);
}
