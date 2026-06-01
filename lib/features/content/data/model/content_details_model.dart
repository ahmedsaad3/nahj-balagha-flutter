import 'package:nahj_balagha_flutter/features/content/data/model/grammar_model.dart';
import 'package:nahj_balagha_flutter/features/content/data/model/reciter_audio_model.dart';
import 'package:nahj_balagha_flutter/features/content/data/model/reference_model.dart';
import 'package:nahj_balagha_flutter/features/content/data/model/scholar_explanation_model.dart';
import 'package:nahj_balagha_flutter/features/content/data/model/sermon_sentence_model.dart';
import 'package:nahj_balagha_flutter/features/content/data/model/vocabulary_model.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';

class ContentDetailsModel extends ContentDetailsEntity {
  const ContentDetailsModel({
    required super.id,
    required super.title,
    required super.category,
    required super.description,
    required super.mainText,
    required super.sentences,
    super.audioPath,
    required super.audios,
    required super.explanations,
    required super.grammars,
    required super.vocabularies,
    required super.references,
  });

  factory ContentDetailsModel.fromJson(Map<String, dynamic> json) {
    return ContentDetailsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      mainText: json['mainText'] as String,
      sentences: (json['sentences'] as List)
          .map(
            (item) =>
                SermonSentenceModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      audioPath: json['audioPath'] as String?,
      audios:
          (json['audios'] as List?)
              ?.map(
                (item) =>
                    ReciterAudioModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      explanations: (json['explanations'] as List)
          .map(
            (item) =>
                ScholarExplanationModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      grammars: (json['grammars'] as List)
          .map((item) => GrammarModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      vocabularies: (json['vocabularies'] as List)
          .map((item) => VocabularyModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      references: (json['references'] as List)
          .map((item) => ReferenceModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
