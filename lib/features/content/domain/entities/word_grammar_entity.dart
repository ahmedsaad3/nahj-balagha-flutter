import 'package:equatable/equatable.dart';

class WordGrammarEntity extends Equatable {
  final String word;
  final String analysisText;

  const WordGrammarEntity({required this.word, required this.analysisText});

  @override
  List<Object?> get props => [word, analysisText];
}
