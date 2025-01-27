class Language {
  final String url;

  Language({required this.url});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}