import 'package:nahj_balagha_flutter/features/content/domain/entities/reciter_audio_entity.dart';

class ReciterAudioModel extends ReciterAudioEntity {
  const ReciterAudioModel({
    required super.reciterName,
    required super.audioPath,
    required super.duration,
  });

  factory ReciterAudioModel.fromJson(Map<String, dynamic> json) {
    return ReciterAudioModel(
      reciterName: json['reciterName'] as String,
      audioPath: json['audioPath'] as String,
      duration: Duration(milliseconds: json['duration'] as int),
    );
  }
}
