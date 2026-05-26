import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/extensions/context_extensions.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/components/phone_input_field_widget.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/update_profile_cubit/update_profile_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/update_profile_cubit/update_profile_state.dart';
import 'package:nahj_balagha_flutter/features/profile/presentation/components/profile_card.dart';
import 'package:nahj_balagha_flutter/shared/components/confirm_buttons_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/input_field_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<UpdateProfileCubit>()
            ..initControllers(context.read<AuthCubit>().state.user),
      child: const _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends StatelessWidget {
  const _ProfileScreenContent();

  @override
  Widget build(BuildContext context) {
    final updateProfileCubit = context.read<UpdateProfileCubit>();
    return Scaffold(
      appBar: UiUtils.appBar(
        context: context,
        centerTitle: true,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      body: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listenWhen: (previous, current) =>
            previous.updateState != current.updateState,
        listener: (context, state) {
          if (state.updateState == RequestState.loaded) {
            // Refresh AuthCubit user
            context.read<AuthCubit>().updateUser(state.user);
            Navigator.pop(context);
            UiUtils.toastMessage(
              context: context,
              message: "تم تحديث الحساب بنجاح",
              backgroundColor: AppColorsLight.primary,
            );
          }
          if (state.updateState == RequestState.error) {
            UiUtils.toastMessage(
              context: context,
              message: state.updateMessage,
              backgroundColor: Colors.redAccent,
            );
          }
        },
        child: Form(
          key: updateProfileCubit.authFormKey,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(HORIZONTAL),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Align(
                      alignment: Alignment.center,
                      child: TextWidget(
                        title: "معلومات الحساب",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColorsLight.primary,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child:
                          BlocSelector<
                            UpdateProfileCubit,
                            UpdateProfileState,
                            ({String image, bool readOnly})
                          >(
                            selector: (state) {
                              return (
                                image: state.user?.image ?? "",
                                readOnly:
                                    state.updateState == RequestState.loading,
                              );
                            },
                            builder: (context, data) {
                              return ProfileCard(imagePath: data.image);
                            },
                          ),
                    ),
                    const SizedBox(height: 20),
                    BlocSelector<UpdateProfileCubit, UpdateProfileState, bool>(
                      selector: (state) {
                        return state.updateState == RequestState.loading;
                      },
                      builder: (context, isLoading) {
                        return Column(
                          spacing: 8,
                          children: [
                            InputFieldWidget(
                              title: "الاسم الكامل",
                              hintText: "الاسم الكامل",
                              textInputType: TextInputType.text,
                              controller: updateProfileCubit.fullNameController,
                              valid: (String? value) => UiUtils.validate(
                                value: value,
                                context: context,
                              ),
                              enabled: !isLoading,
                            ),
                            PhoneInputFieldWidget(
                              controller:
                                  updateProfileCubit.phoneNumberController,
                              readOnly: true,
                              enabled: false,
                            ),
                            InputFieldWidget(
                              title: "البريد الإلكتروني",
                              hintText: "البريد الإلكتروني",
                              textInputType: TextInputType.emailAddress,
                              controller: updateProfileCubit.emailController,
                              valid: (String? value) => UiUtils.validateEmail(
                                value: value,
                                context: context,
                              ),
                              enabled: !isLoading,
                            ),
                          ],
                        );
                      },
                    ),
                  ]),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: HORIZONTAL,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocSelector<
                        UpdateProfileCubit,
                        UpdateProfileState,
                        bool
                      >(
                        selector: (state) {
                          return state.updateState == RequestState.loading;
                        },
                        builder: (context, isLoading) {
                          return ElevatedButtonWidget(
                            isLoading: isLoading,
                            onPressed: () {
                              if (updateProfileCubit.authFormKey.currentState!
                                  .validate()) {
                                UiUtils.showDialogWidgetWithAnimation(
                                  context: context,
                                  title: "تأكيد تحديث الملف الشخصي",
                                  child: ConfirmButtonsWidget(
                                    onYes: () {
                                      Navigator.pop(context);
                                      updateProfileCubit.update();
                                    },
                                  ),
                                );
                              }
                            },
                            title: "تعديل",
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
