import 'package:nahj_balagha_flutter/features/content/data/model/word_grammar_model.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/grammar_model_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/word_grammar_Entity.dart';

class GrammarModel extends GrammarEntity {
  const GrammarModel({
    required super.id,
    required super.sentence,
    required super.analysis,
  });

  factory GrammarModel.fromJson(Map<String, dynamic> json) {
    return GrammarModel(
      id: json['id'] as String,
      sentence: json['sentence'] as String,
      analysis: (json['analysis'] as List)
          .map(
            (item) => WordGrammarModel.fromJson(item as Map<String, dynamic>),
          )
          .toList()
          .cast<WordGrammarEntity>(),
    );
  }
}
