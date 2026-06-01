import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/word_grammar_Entity.dart';

class GrammarEntity extends Equatable {
  final String id;
  final String sentence;
  final List<WordGrammarEntity> analysis;

  const GrammarEntity({
    required this.id,
    required this.sentence,
    required this.analysis,
  });

  @override
  List<Object?> get props => [id, sentence, analysis];
}
