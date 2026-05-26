import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/auth/data/models/user_model.dart';

class SigninState extends Equatable {
  final RequestState signinState;
  final String signinMessage;
  final bool showPassword;
  final UserModel? user;

  const SigninState({
    this.signinState = RequestState.idle,
    this.signinMessage = '',
    this.showPassword = false,
    this.user,
  });

  @override
  List<Object?> get props => [signinState, signinMessage, showPassword, user];

  SigninState copyWith({
    RequestState? signinState,
    String? signinMessage,
    bool? showPassword,
    UserModel? user,
  }) {
    return SigninState(
      signinState: signinState ?? this.signinState,
      signinMessage: signinMessage ?? this.signinMessage,
      showPassword: showPassword ?? this.showPassword,
      user: user ?? this.user,
    );
  }
}
