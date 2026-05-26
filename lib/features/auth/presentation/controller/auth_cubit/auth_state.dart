import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/auth/data/models/user_model.dart';

class AuthState extends Equatable {
  final UserModel? user;

  // Auth State
  final RequestState authCheckState;
  final bool isGuest;
  final String? initialRoute;

  const AuthState({
    this.user,
    this.authCheckState = RequestState.idle,
    this.isGuest = false,
    this.initialRoute,
  });

  @override
  List<Object?> get props => [user, authCheckState, isGuest, initialRoute];

  AuthState copyWith({
    UserModel? user,
    RequestState? authCheckState,
    bool? isGuest,
    String? initialRoute,
  }) {
    return AuthState(
      user: user ?? this.user,
      authCheckState: authCheckState ?? this.authCheckState,
      isGuest: isGuest ?? this.isGuest,
      initialRoute: initialRoute ?? this.initialRoute,
    );
  }
}
