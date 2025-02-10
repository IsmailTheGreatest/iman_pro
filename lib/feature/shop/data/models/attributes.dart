import 'package:iman_invest/feature/shop/data/models/language.dart';
/// Attributes model
class Attributes {
/// Attributes model constructor
  Attributes({
    required this.uz,
    required this.ru,
    required this.en,
  });
/// Attributes model named constructor
  factory Attributes.fromJson(Map<String,dynamic> json) {
    return Attributes(
      uz: Language.fromJson(json['uz'] as Map<String,dynamic> ),
      ru: Language.fromJson(json['ru'] as Map<String,dynamic> ),
      en: Language.fromJson(json['en'] as Map<String,dynamic> ),
    );
  }
  /// Uz language
  final Language uz;
  /// Ru language
  final Language ru;
  /// En language
  final Language en;
/// Attributes model toJson method
  Map<String, dynamic> toJson() {
    return {
      'uz': uz.toJson(),
      'ru': ru.toJson(),
      'en': en.toJson(),
    };
  }
}
