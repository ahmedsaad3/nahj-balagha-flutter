import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/auth/data/models/user_model.dart';

class SignupState extends Equatable {
  final RequestState signupState;
  final String signupMessage;
  final bool showPassword;
  final UserModel? user;

  const SignupState({
    this.signupState = RequestState.idle,
    this.signupMessage = '',
    this.showPassword = false,
    this.user,
  });

  @override
  List<Object?> get props => [signupState, signupMessage, showPassword, user];

  SignupState copyWith({
    RequestState? signupState,
    String? signupMessage,
    bool? showPassword,
    UserModel? user,
  }) {
    return SignupState(
      signupState: signupState ?? this.signupState,
      signupMessage: signupMessage ?? this.signupMessage,
      showPassword: showPassword ?? this.showPassword,
      user: user ?? this.user,
    );
  }
}
