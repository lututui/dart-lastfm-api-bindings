class ImageInfo {
  final SingleImageInfo small;
  final SingleImageInfo medium;
  final SingleImageInfo large;
  final SingleImageInfo extralarge;
  final SingleImageInfo mega;

  ImageInfo({this.small, this.medium, this.large, this.extralarge, this.mega});

  factory ImageInfo.parse(List<dynamic> data) {
    if (data == null) return null;

    final castedList = data.cast<Map<String, dynamic>>();

    final images = {
      for (final entry in castedList)
        entry['size']: SingleImageInfo(entry['size'], entry['#text'])
    };

    return ImageInfo(
      small: images['small'],
      medium: images['medium'],
      large: images['large'],
      extralarge: images['extralarge'],
      mega: images['mega'],
    );
  }
}

class SingleImageInfo {
  final String sizeString;
  final String url;

  SingleImageInfo(this.sizeString, this.url);
}
