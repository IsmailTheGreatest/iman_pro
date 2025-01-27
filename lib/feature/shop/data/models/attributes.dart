import 'language.dart';

class Attributes {
  final Language uz;
  final Language ru;
  final Language en;

  Attributes({
    required this.uz,
    required this.ru,
    required this.en,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      uz: Language.fromJson(json['uz']),
      ru: Language.fromJson(json['ru']),
      en: Language.fromJson(json['en']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uz': uz.toJson(),
      'ru': ru.toJson(),
      'en': en.toJson(),
    };
  }
}