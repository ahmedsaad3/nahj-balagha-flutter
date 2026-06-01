import 'package:nahj_balagha_flutter/features/content/domain/entities/word_grammar_entity.dart';

class WordGrammarModel extends WordGrammarEntity {
  const WordGrammarModel({required super.word, required super.analysisText});

  factory WordGrammarModel.fromJson(Map<String, dynamic> json) {
    return WordGrammarModel(
      word: json['word'] as String,
      analysisText: json['analysisText'] as String,
    );
  }
}
