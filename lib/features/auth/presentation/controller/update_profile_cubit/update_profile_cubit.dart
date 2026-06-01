import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/auth/data/models/user_model.dart';
import 'package:nahj_balagha_flutter/features/auth/data/repository/token_repository.dart';
import 'package:nahj_balagha_flutter/features/auth/data/domain/usecases/update_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/update_profile_cubit/update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateUseCase _updateUseCase;
  final TokenRepository _tokenRepository;

  UpdateProfileCubit({
    required UpdateUseCase updateUseCase,
    required TokenRepository tokenRepository,
  }) : _updateUseCase = updateUseCase,
       _tokenRepository = tokenRepository,
       super(const UpdateProfileState());

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController schoolSpecializationIDController =
      TextEditingController();
  TextEditingController specializationIDController = TextEditingController();
  TextEditingController phoneNumberTypeController = TextEditingController(
    text: "+964",
  );

  GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

  void initControllers(UserModel? user) {
    if (user == null) return;

    fullNameController = TextEditingController(text: user.fullName);
    userNameController = TextEditingController(text: user.userName);
    phoneNumberController = TextEditingController(text: user.phoneNumber);
    emailController = TextEditingController(text: user.email);
    schoolSpecializationIDController = TextEditingController(
      text: user.schoolSpecializationID.toString(),
    );
    specializationIDController = TextEditingController(
      text: user.specializationID.toString(),
    );
    phoneNumberTypeController = TextEditingController(
      text: user.phoneNumber.split(' ').first,
    );

    emit(state.copyWith(user: user));
  }

  void disposeControllers() {
    fullNameController.dispose();
    userNameController.dispose();
    phoneNumberController.dispose();
    phoneNumberTypeController.dispose();
    emailController.dispose();
    schoolSpecializationIDController.dispose();
    specializationIDController.dispose();
  }

  Future<void> update() async {
    if (!authFormKey.currentState!.validate()) {
      return;
    }
    authFormKey.currentState!.save();
    emit(state.copyWith(updateState: RequestState.loading));

    final result = await _updateUseCase(
      params: UpdateUserInfoParams(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        specializationID: int.tryParse(specializationIDController.text) ?? 0,
        schoolSpecializationID:
            int.tryParse(schoolSpecializationIDController.text) ?? 0,
      ),
    );
    if (result is Success) {
      final updatedUser = result.response;
      await _tokenRepository.saveUser(updatedUser);
      emit(state.copyWith(updateState: RequestState.loaded, user: updatedUser));
      return;
    }
    if (result is Failure) {
      ErrorMessageModel errorMessage = result.response;
      emit(
        state.copyWith(
          updateState: RequestState.error,
          updateMessage: errorMessage.message,
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
