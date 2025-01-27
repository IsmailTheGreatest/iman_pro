import 'data.dart';

class BannerApiResponse {
  final Data data;

  BannerApiResponse({required this.data});

  factory BannerApiResponse.fromJson(Map<String, dynamic> json) {
    return BannerApiResponse(
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}








