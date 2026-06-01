import 'package:nahj_balagha_flutter/features/content/domain/entities/vocabulary_entity.dart';

class VocabularyModel extends VocabularyEntity {
  const VocabularyModel({
    required super.id,
    required super.word,
    required super.definition,
  });

  factory VocabularyModel.fromJson(Map<String, dynamic> json) {
    return VocabularyModel(
      id: json['id'] as String,
      word: json['word'] as String,
      definition: json['definition'] as String,
    );
  }
}
