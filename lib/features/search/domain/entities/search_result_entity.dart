import 'package:equatable/equatable.dart';

class SearchResultEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final String filter;
  final String category;

  const SearchResultEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.filter,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, content, filter, category];
}
