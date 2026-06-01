import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/services/cache_helper.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/auth/data/repository/token_repository.dart';
import 'package:nahj_balagha_flutter/features/auth/data/domain/usecases/signin_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/signin_cubit/signin_state.dart';
import 'package:nahj_balagha_flutter/firebase/firebase_notification_service.dart';

class SigninCubit extends Cubit<SigninState> {
  final SigninUseCase _signinUseCase;
  final TokenRepository _tokenRepository;

  SigninCubit({
    required SigninUseCase signinUseCase,
    required TokenRepository tokenRepository,
  }) : _signinUseCase = signinUseCase,
       _tokenRepository = tokenRepository,
       super(const SigninState());

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController phoneNumberTypeController = TextEditingController(
    text: "+964",
  );
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void init() {
    emit(const SigninState());
  }

  void initControllers() {
    phoneNumberController = TextEditingController();
    phoneNumberTypeController = TextEditingController(text: "+964");
    passwordController = TextEditingController();
  }

  void disposeControllers() {
    phoneNumberController.dispose();
    phoneNumberTypeController.dispose();
    passwordController.dispose();
  }

  Future<void> signin() async {
    if (!authFormKey.currentState!.validate()) {
      return;
    }
    authFormKey.currentState!.save();

    emit(state.copyWith(signinState: RequestState.loading));
    final String tokenNotification =
        await FirebaseNotificationService.getNotificationToken() ?? "";
    final result = await _signinUseCase(
      params: {
        "phoneNumber":
            "${phoneNumberTypeController.text.trim()} ${phoneNumberController.text.trim()}",
        "password": passwordController.text.trim(),
        "tokenNotification": tokenNotification,
      },
    );
    if (result is Success) {
      final user = result.response["visitor"];
      await _tokenRepository.set(token: result.response["token"], user: user);
      await CacheHelper.removeData(key: IS_GUEST_KEY);

      emit(state.copyWith(signinState: RequestState.loaded, user: user));
      return;
    }
    if (result is Failure) {
      ErrorMessageModel errorMessage = result.response;
      emit(
        state.copyWith(
          signinState: RequestState.error,
          signinMessage: errorMessage.message,
        ),
      );
      return;
    }
  }

  @override
  Future<void> close() {
    initControllers();
    return super.close();
  }
}
