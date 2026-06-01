import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/grammar_model_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/reciter_audio_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/reference_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/scholar_explanation_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/sermon_sentence_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/vocabulary_entity.dart';

class ContentDetailsEntity extends Equatable {
  final String id;
  final String title;
  final String category;
  final String description;
  final String mainText;
  final String? audioPath;
  final List<SermonSentenceEntity> sentences;
  final List<ReciterAudioEntity> audios;
  final List<ScholarExplanationEntity> explanations;
  final List<GrammarEntity> grammars;
  final List<VocabularyEntity> vocabularies;
  final List<ReferenceEntity> references;

  const ContentDetailsEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.mainText,
    required this.sentences,
    this.audioPath,
    this.audios = const [],
    required this.explanations,
    required this.grammars,
    required this.vocabularies,
    required this.references,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    description,
    mainText,
    sentences,
    audioPath,
    audios,
    explanations,
    grammars,
    vocabularies,
    references,
  ];
}
