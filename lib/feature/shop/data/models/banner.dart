import 'attributes.dart';

class Banner {
  final String id;
  final String name;
  final String link;
  final String status;
  final String location;
  final String startedAt;
  final String endAt;
  final String createdAt;
  final String updatedAt;
  final Attributes attributes;

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

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      name: json['name'],
      link: json['link'],
      status: json['status'],
      location: json['location'],
      startedAt: json['started_at'],
      endAt: json['end_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      attributes: Attributes.fromJson(json['attributes']),
    );
  }

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