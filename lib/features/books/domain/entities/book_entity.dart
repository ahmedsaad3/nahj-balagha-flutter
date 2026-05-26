import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String title;
  final String author;
  final String coverImage;
  final String description;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.coverImage,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, author, coverImage, description];
}
