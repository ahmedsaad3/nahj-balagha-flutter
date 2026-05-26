import 'package:equatable/equatable.dart';

class Success<T> extends Result<T> {
  const Success({super.code, super.response});
}

class Failure<T> extends Result<T> {
  const Failure({super.code, super.response});
}

abstract class Result<T> extends Equatable {
  final int? code;
  final T? response;
  const Result({this.code, this.response});

  @override
  List<Object?> get props => [code, response];
}
