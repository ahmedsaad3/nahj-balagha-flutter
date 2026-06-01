import 'package:equatable/equatable.dart';

class VocabularyEntity extends Equatable {
  final String id;
  final String word;
  final String definition;

  const VocabularyEntity({
    required this.id,
    required this.word,
    required this.definition,
  });

  @override
  List<Object?> get props => [id, word, definition];
}
