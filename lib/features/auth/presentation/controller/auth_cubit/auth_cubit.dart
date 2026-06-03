import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/features/auth/data/models/user_model.dart';
import 'package:nahj_balagha_flutter/features/auth/data/repository/token_repository.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final TokenRepository _tokenRepository;
  AuthCubit({required TokenRepository tokenRepository})
    : _tokenRepository = tokenRepository,
      super(const AuthState());

  UserModel? _user;


  Future<void> checkAuthenticationStatus() async {
    emit(state.copyWith(authCheckState: RequestState.loading));

    // 2) Load token, check validity
    final token = await _tokenRepository.getTokenFromStorage();
    if (token == null || token.isEmpty) {
      await logout();
      emit(
        state.copyWith(
          authCheckState: RequestState.loaded,
          isGuest: false,
          initialRoute: AppRoutes.welcomeScreen,
        ),
      );
      return;
    }

    final expired = await _tokenRepository.checkExpiration();
    if (expired) {
      await logout();
      emit(
        state.copyWith(
          authCheckState: RequestState.loaded,
          isGuest: false,
          initialRoute: AppRoutes.welcomeScreen,
        ),
      );
      return;
    }

    // 3) Load user
    final user = await _tokenRepository.getUserFromStorage();
    if (user == null) {
      await logout();
      emit(
        state.copyWith(
          authCheckState: RequestState.loaded,
          isGuest: false,
          initialRoute: AppRoutes.welcomeScreen,
        ),
      );
      return;
    }

    // 4) Success → Home
    _user = user;
    emit(
      state.copyWith(
        authCheckState: RequestState.loaded,
        isGuest: false,
        // initialRoute: AppRoutes.homeScreen,
        user: _user,
      ),
    );
  }

  Future<void> logout() async {
    await _tokenRepository.logout();
    _user = null;
    emit(
      state.copyWith(
        authCheckState: RequestState.loaded,
        initialRoute: AppRoutes.welcomeScreen,
        isGuest: false,
        user: null,
      ),
    );
  }

  void updateUser(UserModel? user) {
    _user = user;
    emit(state.copyWith(user: user, isGuest: false));
  }
}
