import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    super.description,
    super.scholarId,
    super.scholarName,
    super.bookTypeId,
    super.bookTypeName,
    super.publishingYear,
    super.publisher,
    super.publishPlace,
    super.pageCounts,
    super.coverImage,
    super.pdfFile,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      scholarId: json['scholarId'] as String?,
      scholarName: json['scholarName'] as String?,
      bookTypeId: json['bookTypeId'] as String?,
      bookTypeName: json['bookTypeName'] as String?,
      publishingYear: json['publishingYear'] as int?,
      publisher: json['publisher'] as String?,
      publishPlace: json['publishPlace'] as String?,
      pageCounts: json['pageCounts'] as int?,
      coverImage: json['coverImage'] as String?,
      pdfFile: json['pdfFile'] as String?,
    );
  }
}
