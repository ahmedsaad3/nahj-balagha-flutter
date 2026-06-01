import 'package:nahj_balagha_flutter/features/content/domain/entities/sermon_sentence_entity.dart';

class SermonSentenceModel extends SermonSentenceEntity {
  const SermonSentenceModel({
    required super.id,
    required super.text,
    super.audioStart,
    super.audioEnd,
  });

  factory SermonSentenceModel.fromJson(Map<String, dynamic> json) {
    return SermonSentenceModel(
      id: json['id'] as String,
      text: json['text'] as String,
      audioStart: json['audioStart'] != null
          ? Duration(milliseconds: json['audioStart'] as int)
          : null,
      audioEnd: json['audioEnd'] != null
          ? Duration(milliseconds: json['audioEnd'] as int)
          : null,
    );
  }
}
