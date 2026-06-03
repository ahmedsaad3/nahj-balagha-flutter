import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/auth/data/repository/token_repository.dart';
import 'package:nahj_balagha_flutter/features/auth/data/domain/usecases/signup_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/signup_cubit/signup_state.dart';
import 'package:nahj_balagha_flutter/firebase/firebase_notification_service.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;
  final TokenRepository _tokenRepository;

  SignupCubit({
    required SignupUseCase signupUseCase,
    required TokenRepository tokenRepository,
  }) : _signupUseCase = signupUseCase,
       _tokenRepository = tokenRepository,
       super(const SignupState());

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController phoneNumberTypeController = TextEditingController(
    text: "+964",
  );
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController schoolSpecializationIDController =
      TextEditingController();
  TextEditingController specializationIDController = TextEditingController();
  final GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void initControllers() {
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    phoneNumberTypeController = TextEditingController(text: "+964");
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    addressController = TextEditingController();
    schoolSpecializationIDController = TextEditingController();
    specializationIDController = TextEditingController();
  }

  void disposeControllers() {
    fullNameController.dispose();
    userNameController.dispose();
    phoneNumberController.dispose();
    phoneNumberTypeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    schoolSpecializationIDController.dispose();
    specializationIDController.dispose();
  }

  Future<void> signup({required List<Map<String, dynamic>> interests}) async {
    emit(state.copyWith(signupState: RequestState.loading));
    final String tokenNotification =
        await FirebaseNotificationService.getNotificationToken() ?? "";
    final result = await _signupUseCase(
      params: SignupParams(
        fullName: fullNameController.text.trim(),
        userName: userNameController.text.trim(),
        password: passwordController.text.trim(),
        address: addressController.text.trim(),
        tokenNotification: tokenNotification,
        phoneNumber:
            "${phoneNumberTypeController.text.trim()} ${phoneNumberController.text.trim()}",
        email: emailController.text.trim(),
        schoolSpecializationID: int.parse(
          schoolSpecializationIDController.text.trim(),
        ),
        specializationID: int.parse(specializationIDController.text.trim()),
        interests: interests,
      ),
    );

    if (result is Success) {
      final user = result.response["visitor"];
      final token = result.response["token"];
      await _tokenRepository.set(token: token, user: user);

      emit(state.copyWith(signupState: RequestState.loaded, user: user));
      return;
    }
    if (result is Failure) {
      ErrorMessageModel errorMessage = result.response;
      print(errorMessage.message);
      print(errorMessage.statusCode);
      emit(
        state.copyWith(
          signupState: RequestState.error,
          signupMessage: errorMessage.message,
        ),
      );
      return;
    }
  }

  @override
  Future<void> close() {
    disposeControllers();
    return super.close();
  }
}
