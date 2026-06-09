import 'package:equatable/equatable.dart';

class FavoriteItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category; // e.g. "الخطب", "الرسائل", "المفردات", "الكتب", "الإعراب", "صوتيات"
  final String url;
  final bool hasAudio;

  const FavoriteItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.url,
    required this.hasAudio,
  });

  @override
  List<Object?> get props => [id, title, description, category, url, hasAudio];
}
