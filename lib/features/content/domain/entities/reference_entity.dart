import 'package:equatable/equatable.dart';

class ReferenceEntity extends Equatable {
  final String id;
  final String source;
  final String details;

  const ReferenceEntity({
    required this.id,
    required this.source,
    required this.details,
  });

  @override
  List<Object?> get props => [id, source, details];
}
