import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/settings/domain/entities/faqs.dart';

class FAQsState extends Equatable {
  final RequestState faqsState;
  final List<FAQs> faqs;
  final String errorMessage;
  final String? expandedFaqId;
  final String searchQuery;

  List<FAQs> get filteredFaqs {
    if (searchQuery.isEmpty) {
      return faqs;
    }
    return faqs.where((faq) {
      return faq.question.contains(searchQuery) ||
          faq.answer.contains(searchQuery);
    }).toList();
  }

  const FAQsState({
    this.faqsState = RequestState.idle,
    this.faqs = const [],
    this.errorMessage = '',
    this.expandedFaqId,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [
    faqsState,
    faqs,
    errorMessage,
    expandedFaqId,
    searchQuery,
  ];

  FAQsState copyWith({
    RequestState? faqsState,
    List<FAQs>? faqs,
    String? errorMessage,
    String? expandedFaqId,
    String? searchQuery,
    bool clearExpandedFaqId = false,
  }) {
    return FAQsState(
      faqsState: faqsState ?? this.faqsState,
      faqs: faqs ?? this.faqs,
      errorMessage: errorMessage ?? this.errorMessage,
      expandedFaqId: clearExpandedFaqId
          ? null
          : (expandedFaqId ?? this.expandedFaqId),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
