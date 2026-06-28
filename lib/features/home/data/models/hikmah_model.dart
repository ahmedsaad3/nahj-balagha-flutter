import 'package:nahj_balagha_flutter/features/home/domain/entities/hikmah_entity.dart';

class HikmahModel extends HikmahEntity {
  const HikmahModel({
    required super.id,
    required super.text,
    super.benefit,
    super.gharib,
  });

  factory HikmahModel.fromJson(Map<String, dynamic> json) {
    return HikmahModel(
      id: json['id'],
      text: json['text'],
      benefit: json['benefit'],
      gharib: json['gharib'],
    );
  }
}
