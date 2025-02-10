import 'package:iman_invest/feature/shop/data/models/banner.dart';
/// Data model
class Data {
/// Data model constructor
  Data({required this.list});
/// Data model named constructor
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      list: (json['list'] as List<dynamic>?)
          ?.map((item) => Banner.fromJson(item as Map<String, dynamic>))
          .toList() ??
          <Banner>[],
    );
  }

  /// List of banners
  final List<Banner> list;
/// Data model toJson method
  Map<String, dynamic> toJson() {
    return {
      'list': list.map((item) => item.toJson()).toList(),
    };
  }
}
