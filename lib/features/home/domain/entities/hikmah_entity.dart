import 'package:equatable/equatable.dart';

class HikmahEntity extends Equatable {
  final String id;
  final String text;
  final String? benefit;
  final String? gharib;

  const HikmahEntity({
    required this.id,
    required this.text,
    this.benefit,
    this.gharib,
  });

  @override
  List<Object?> get props => [id, text, benefit, gharib];
}
