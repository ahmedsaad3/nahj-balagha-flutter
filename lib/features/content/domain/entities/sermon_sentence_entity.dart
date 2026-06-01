import 'package:equatable/equatable.dart';

class SermonSentenceEntity extends Equatable {
  final String id;
  final String text;
  final Duration? audioStart;
  final Duration? audioEnd;

  const SermonSentenceEntity({
    required this.id,
    required this.text,
    this.audioStart,
    this.audioEnd,
  });

  @override
  List<Object?> get props => [id, text, audioStart, audioEnd];
}
