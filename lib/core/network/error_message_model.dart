import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String message;
  final int statusCode;
  const ErrorMessageModel({required this.message, this.statusCode = 0});
  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  @override
  List<Object?> get props => [message, statusCode];
}
