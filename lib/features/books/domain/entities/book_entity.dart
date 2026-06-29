import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? scholarId;
  final String? scholarName;
  final String? bookTypeId;
  final String? bookTypeName;
  final int? publishingYear;
  final String? publisher;
  final String? publishPlace;
  final int? pageCounts;
  final String? coverImage;
  final String? pdfFile;
  final String? createdAt;
  final String? updatedAt;

  const BookEntity({
    required this.id,
    required this.title,
    this.description,
    this.scholarId,
    this.scholarName,
    this.bookTypeId,
    this.bookTypeName,
    this.publishingYear,
    this.publisher,
    this.publishPlace,
    this.pageCounts,
    this.coverImage,
    this.pdfFile,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        scholarId,
        scholarName,
        bookTypeId,
        bookTypeName,
        publishingYear,
        publisher,
        publishPlace,
        pageCounts,
        coverImage,
        pdfFile,
        createdAt,
        updatedAt,
      ];
}
