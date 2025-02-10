import 'package:iman_invest/feature/shop/data/models/data.dart';

/// BannerApiResponse model
class BannerApiResponse {
  /// BannerApiResponse model constructor
  BannerApiResponse({required this.data});

  /// BannerApiResponse model named constructor
  factory BannerApiResponse.fromJson(
    Map<String, Map<String, Iterable<Map<String, String>>>> json,
  ) {
    return BannerApiResponse(
      data: Data.fromJson(json['data']!),
    );
  }

  /// Data
  final Data data;

  /// BannerApiResponse model toJson method
  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}
