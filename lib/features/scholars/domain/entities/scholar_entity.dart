import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';

class ScholarEntity extends Equatable {
  final String id;
  final String name;
  final String specialization;
  final String bio;
  final String image;
  final bool isCommentator;
  final List<BookEntity> works;

  const ScholarEntity({
    required this.id,
    required this.name,
    required this.specialization,
    required this.bio,
    required this.image,
    required this.isCommentator,
    required this.works,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    specialization,
    bio,
    image,
    isCommentator,
    works,
  ];
}
