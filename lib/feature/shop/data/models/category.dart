import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String guid;
  final String slug;
  final String title;
  final String banner;
  final String createdAt;
  final String updatedAt;

  const Category({
    required this.guid,
    required this.slug,
    required this.title,
    required this.banner,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory method to create a CategoryModel from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      guid: json['Guid'] as String,
      slug: json['Slug'] as String,
      title: json['Title'] as String,
      banner: json['Banner'] as String? ?? '',
      createdAt: json['CreatedAt'] as String? ??'',
      updatedAt: json['UpdatedAt'] as String? ??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Guid': guid,
      'Slug': slug,
      'Title': title,
      'Banner': banner,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [guid, slug, title, banner, createdAt, updatedAt];
}
