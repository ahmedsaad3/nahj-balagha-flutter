import 'package:equatable/equatable.dart';

class ReciterAudioEntity extends Equatable {
  final String reciterName;
  final String audioPath;
  final Duration duration;

  const ReciterAudioEntity({
    required this.reciterName,
    required this.audioPath,
    required this.duration,
  });

  @override
  List<Object?> get props => [reciterName, audioPath, duration];
}
