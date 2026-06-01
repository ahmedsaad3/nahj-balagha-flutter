import 'package:equatable/equatable.dart';

class ScholarExplanationEntity extends Equatable {
  final String id;
  final String scholarName;
  final String excerpt;
  final String fullText;

  const ScholarExplanationEntity({
    required this.id,
    required this.scholarName,
    required this.excerpt,
    required this.fullText,
  });

  @override
  List<Object?> get props => [id, scholarName, excerpt, fullText];
}
