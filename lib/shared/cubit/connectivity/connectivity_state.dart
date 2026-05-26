import 'package:equatable/equatable.dart';

class ConnectivityState extends Equatable {
  final bool isConnected;

  const ConnectivityState({this.isConnected = true});

  @override
  List<Object?> get props => [isConnected];

  ConnectivityState copyWith({bool? isConnected}) {
    return ConnectivityState(isConnected: isConnected ?? this.isConnected);
  }
}
