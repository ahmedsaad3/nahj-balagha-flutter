import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/cache_helper.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
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

  Future<bool> _checkGuestStatus() async {
    try {
      return CacheHelper.getBoolean(key: IS_GUEST_KEY) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> setGuestStatus(bool isGuest) async {
    try {
      await CacheHelper.setBoolean(key: IS_GUEST_KEY, value: isGuest);
      emit(
        state.copyWith(
          isGuest: isGuest,
          initialRoute: AppRoutes.welcomeScreen,
          authCheckState: RequestState.loaded,
        ),
      );
    } catch (e) {
      print('Error setting guest status: $e');
    }
  }

  Future<void> checkAuthenticationStatus() async {
    emit(state.copyWith(authCheckState: RequestState.loading));

    // 1) Guest Mode
    if (await _checkGuestStatus()) {
      emit(
        state.copyWith(
          authCheckState: RequestState.loaded,
          isGuest: true,
          // initialRoute: AppRoutes.homeScreen,
        ),
      );
      return;
    }

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
    await CacheHelper.removeData(key: IS_GUEST_KEY);
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
