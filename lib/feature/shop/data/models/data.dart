import 'banner.dart';

class Data {
  final List<Banner> list;

  Data({required this.list});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      list: List<Banner>.from(json['list'].map((item) => Banner.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((item) => item.toJson()).toList(),
    };
  }
}