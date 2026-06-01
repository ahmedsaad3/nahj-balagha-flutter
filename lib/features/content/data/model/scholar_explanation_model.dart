import 'package:nahj_balagha_flutter/features/content/domain/entities/scholar_explanation_entity.dart';

class ScholarExplanationModel extends ScholarExplanationEntity {
  const ScholarExplanationModel({
    required super.id,
    required super.scholarName,
    required super.excerpt,
    required super.fullText,
  });

  factory ScholarExplanationModel.fromJson(Map<String, dynamic> json) {
    return ScholarExplanationModel(
      id: json['id'] as String,
      scholarName: json['scholarName'] as String,
      excerpt: json['excerpt'] as String,
      fullText: json['fullText'] as String,
    );
  }
}
