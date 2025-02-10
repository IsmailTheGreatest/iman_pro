import 'package:iman_invest/feature/shop/data/models/attributes.dart';
/// Banner model
class Banner {
/// Banner model constructor
  Banner({
    required this.id,
    required this.name,
    required this.link,
    required this.status,
    required this.location,
    required this.startedAt,
    required this.endAt,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
  });
/// Banner model named constructor
  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'].toString(),
      name: json['name'].toString(),
      link: json['link'].toString(),
      status: json['status'].toString(),
      location: json['location'].toString(),
      startedAt: json['started_at'].toString(),
      endAt: json['end_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      attributes: Attributes.fromJson(
        json['attributes']! as Map<String, dynamic>,
      ),
    );
  }
  ///id
  final String id;
  ///name
  final String name;
  ///link
  final String link;
  ///status
  final String status;
  ///location
  final String location;
  ///startedAt
  final String startedAt;
  ///endAt
  final String endAt;
  ///createdAt
  final String createdAt;
  ///updatedAt
  final String updatedAt;
  ///attributes
  final Attributes attributes;
/// Banner model toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'status': status,
      'location': location,
      'started_at': startedAt,
      'end_at': endAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'attributes': attributes.toJson(),
    };
  }
}
