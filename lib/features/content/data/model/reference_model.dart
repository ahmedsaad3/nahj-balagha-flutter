import 'package:nahj_balagha_flutter/features/content/domain/entities/reference_entity.dart';

class ReferenceModel extends ReferenceEntity {
  const ReferenceModel({
    required super.id,
    required super.source,
    required super.details,
  });

  factory ReferenceModel.fromJson(Map<String, dynamic> json) {
    return ReferenceModel(
      id: json['id'] as String,
      source: json['source'] as String,
      details: json['details'] as String,
    );
  }
}
