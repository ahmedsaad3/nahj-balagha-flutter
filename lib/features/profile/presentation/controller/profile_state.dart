import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';

class ProfileState extends Equatable {
  final RequestState changePasswordState;
  final String changePasswordMessage;
  final bool showPassword;

  const ProfileState({
    this.changePasswordState = RequestState.idle,
    this.changePasswordMessage = '',
    this.showPassword = false,
  });

  @override
  List<Object?> get props => [
    changePasswordState,
    changePasswordMessage,
    showPassword,
  ];

  ProfileState copyWith({
    RequestState? changePasswordState,
    String? changePasswordMessage,
    bool? showPassword,
  }) {
    return ProfileState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
      changePasswordMessage:
          changePasswordMessage ?? this.changePasswordMessage,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}
