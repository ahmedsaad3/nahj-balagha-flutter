import 'package:nahj_balagha_flutter/features/settings/domain/entities/faqs.dart';

class FAQsModel extends FAQs {
  const FAQsModel({
    required super.id,
    required super.question,
    required super.answer,
  });

  factory FAQsModel.fromJson(Map<String, dynamic> json) {
    return FAQsModel(
      id: json['questionAndAnswerID'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}
