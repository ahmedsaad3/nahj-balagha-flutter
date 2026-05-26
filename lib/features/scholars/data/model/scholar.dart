import 'package:nahj_balagha_flutter/features/books/data/model/book.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';

class ScholarModel extends ScholarEntity {
  const ScholarModel({
    required super.id,
    required super.name,
    required super.specialization,
    required super.bio,
    required super.image,
    required super.isCommentator,
    required super.works,
  });

  factory ScholarModel.fromJson(Map<String, dynamic> json) {
    return ScholarModel(
      id: json['id'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      bio: json['bio'] as String,
      image: json['image'] as String,
      isCommentator: json['isCommentator'] as bool? ?? false,
      works:
          (json['works'] as List<dynamic>?)
              ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'bio': bio,
      'image': image,
      'isCommentator': isCommentator,
      'works': works.map((e) => (e as BookModel).toJson()).toList(),
    };
  }
}
