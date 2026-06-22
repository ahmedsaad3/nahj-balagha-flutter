import 'package:equatable/equatable.dart';

class ScholarEntity extends Equatable {
  final String id;
  final String fullName;
  final String title;
  final String bio;
  final int? birthYear;
  final int? deathYear;
  final String imageUrl;
  final String personTypeId;
  final String personTypeName;
  final String createdAt;
  final String? updatedAt;
  // final List<BookEntity> books;

  const ScholarEntity({
    required this.id,
    required this.fullName,
    required this.title,
    required this.bio,
    this.birthYear,
    this.deathYear,
    required this.imageUrl,
    required this.personTypeId,
    required this.personTypeName,
    required this.createdAt,
    this.updatedAt,
    // required this.books,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    title,
    bio,
    birthYear,
    deathYear,
    imageUrl,
    personTypeId,
    personTypeName,
    createdAt,
    updatedAt,
    // books,
  ];
}
