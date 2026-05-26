import 'package:equatable/equatable.dart';

class WisdomEntity extends Equatable {
  final String id;
  final String text;
  final String source;
  final String? benefit;
  final String? difficultWords;

  const WisdomEntity({
    required this.id,
    required this.text,
    required this.source,
    this.benefit,
    this.difficultWords,
  });

  @override
  List<Object?> get props => [id, text, source, benefit, difficultWords];
}
