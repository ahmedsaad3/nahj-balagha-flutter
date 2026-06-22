import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';

class ScholarModel extends ScholarEntity {
  const ScholarModel({
    required super.id,
    required super.fullName,
    required super.title,
    required super.bio,
    required super.birthYear,
    required super.deathYear,
    required super.imageUrl,
    required super.personTypeId,
    required super.personTypeName,
    required super.createdAt,
    required super.updatedAt,
    // required super.books,
  });

  factory ScholarModel.fromJson(Map<String, dynamic> json) {
    return ScholarModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String? ?? '',
      title: json['title'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      birthYear: json['birthYear'] as int?,
      deathYear: json['deathYear'] as int?,
      imageUrl: json['imageUrl'] as String? ?? '',
      personTypeId: json['personTypeId'] as String? ?? '',
      personTypeName: json['personTypeName'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String?,
      // books:
      //     (json['books'] as List<dynamic>?)
      //         ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
      //         .toList() ??
      //     const [],
    );
  }
}
