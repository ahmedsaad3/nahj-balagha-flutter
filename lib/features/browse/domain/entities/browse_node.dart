import 'package:equatable/equatable.dart';

class ContentSnippet extends Equatable {
  final String id;
  final String title;
  final String excerpt;
  final String fullText;

  const ContentSnippet({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.fullText,
  });

  @override
  List<Object?> get props => [id, title, excerpt, fullText];
}

class BrowseNode extends Equatable {
  final String id;
  final String title;
  final String? count;
  final List<BrowseNode> children;
  final List<ContentSnippet> content;
  final bool isAlphabetical;

  const BrowseNode({
    required this.id,
    required this.title,
    this.count,
    this.children = const [],
    this.content = const [],
    this.isAlphabetical = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        count,
        children,
        content,
        isAlphabetical,
      ];
}
