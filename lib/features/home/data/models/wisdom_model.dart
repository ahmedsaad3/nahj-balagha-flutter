import 'package:nahj_balagha_flutter/features/home/domain/entities/wisdom_entity.dart';

class WisdomModel extends WisdomEntity {
  const WisdomModel({
    required super.id,
    required super.text,
    required super.source,
    super.benefit,
    super.difficultWords,
  });

  factory WisdomModel.fromJson(Map<String, dynamic> json) {
    return WisdomModel(
      id: json['id'] as String,
      text: json['text'] as String,
      source: json['source'] as String,
      benefit: json['benefit'] as String?,
      difficultWords: json['difficultWords'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'source': source,
      'benefit': benefit,
      'difficultWords': difficultWords,
    };
  }
}
