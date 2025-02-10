/// Language model class
class Language {
/// Language model constructor
  Language({required this.url});

  /// Language model constructor
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      url: json['url'].toString(),
    );
  }
  /// Language url
  final String url;
/// Language model toJson method
  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
