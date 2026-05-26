import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/components/phone_input_field_widget.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/signup_cubit/signup_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/signup_cubit/signup_state.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/input_field_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignupCubit>()..initControllers(),
      child: const _SignupScreenContent(),
    );
  }
}

class _SignupScreenContent extends StatelessWidget {
  const _SignupScreenContent();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final SignupCubit signupCubit = context.read<SignupCubit>();
        return Scaffold(
          appBar: UiUtils.appBar(
            context: context,
            backIconColor: AppColorsLight.black,
            backgroundColor: AppColorsLight.white,
          ),
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
            bottom: false,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: signupCubit.authFormKey,
                child: BlocConsumer<SignupCubit, SignupState>(
                  listenWhen: (previous, current) =>
                      previous.signupState != current.signupState,
                  buildWhen: (previous, current) =>
                      previous.signupState != current.signupState,
                  listener: (context, state) {
                    if (state.signupState == RequestState.loaded) {
                      UiUtils.toastMessage(
                        context: context,
                        message: "تم التسجيل بنجاح",
                        backgroundColor: Colors.green,
                      );
                    }
                    if (state.signupState == RequestState.error) {
                      UiUtils.toastMessage(
                        context: context,
                        message: state.signupMessage,
                        backgroundColor: Colors.redAccent,
                      );
                    }
                  },
                  builder: (context, state) {
                    final bool isLoading =
                        state.signupState == RequestState.loading;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 14,
                      children: [
                        TextWidget(
                          title: "إنشاء حساب",
                          fontSize: 16,
                        ),
                        const SizedBox(height: 5),
                        InputFieldWidget(
                          title: "الاسم الكامل",
                          hintText: "أدخل اسمك الكامل",
                          readOnly: isLoading,
                          textInputType: TextInputType.text,
                          controller: signupCubit.fullNameController,
                          valid: (String? value) =>
                              UiUtils.validate(value: value, context: context),
                          enabled: !isLoading,
                        ),
                        InputFieldWidget(
                          title: "البريد الإلكتروني",
                          hintText: "أدخل بريدك الإلكتروني",
                          readOnly: isLoading,
                          textInputType: TextInputType.emailAddress,
                          controller: signupCubit.emailController,
                          valid: (String? value) => UiUtils.validateEmail(
                            value: value,
                            context: context,
                          ),
                          enabled: !isLoading,
                        ),

                        PhoneInputFieldWidget(
                          controller: signupCubit.phoneNumberController,
                          enabled: !isLoading,
                          onCountryChanged: (country) {
                            signupCubit.phoneNumberTypeController.text = country
                                .dialCode
                                .toString();
                          },
                          onPhoneNumberChanged: (fullNumber) {
                            signupCubit.phoneNumberController.text =
                                fullNumber ?? "";
                            return;
                          },
                        ),

                        InputFieldWidget(
                          title: "اسم المستخدم",
                          hintText: "أدخل اسم المستخدم",
                          readOnly: isLoading,
                          textInputType: TextInputType.text,
                          controller: signupCubit.userNameController,
                          valid: (String? value) => UiUtils.validateUsername(
                            value: value,
                            context: context,
                          ),
                          enabled: !isLoading,
                        ),

                        BlocSelector<SignupCubit, SignupState, bool>(
                          selector: (state) {
                            return state.showPassword;
                          },
                          builder: (context, showPassword) {
                            return Column(
                              spacing: 14,
                              children: [
                                InputFieldWidget(
                                  title: "كلمة المرور",
                                  hintText: "أدخل كلمة المرور",
                                  readOnly: isLoading,
                                  textInputType: TextInputType.visiblePassword,
                                  controller: signupCubit.passwordController,
                                  enableShowPassword: true,
                                  showPassword: !showPassword,
                                  onPressedShowPassword:
                                      signupCubit.togglePasswordVisibility,
                                  valid: (String? value) =>
                                      UiUtils.validatePassword(
                                        value: value,
                                        context: context,
                                      ),
                                  enabled: !isLoading,
                                ),
                                InputFieldWidget(
                                  title: "تأكيد كلمة المرور",
                                  hintText:
                                      "تأكيد كلمة المرور",
                                  readOnly: isLoading,
                                  textInputType: TextInputType.visiblePassword,
                                  controller:
                                      signupCubit.confirmPasswordController,
                                  enableShowPassword: true,
                                  showPassword: !showPassword,
                                  onPressedShowPassword:
                                      signupCubit.togglePasswordVisibility,
                                  valid: (String? value) =>
                                      UiUtils.validatePassword(
                                        value: value,
                                        context: context,
                                        value2:
                                            signupCubit.passwordController.text,
                                      ),
                                  enabled: !isLoading,
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 4),

                        Column(
                          spacing: 12,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButtonWidget(
                              isLoading: isLoading,
                              onPressed: () {
                                if (signupCubit.authFormKey.currentState!
                                    .validate()) {
                                  return;
                                }
                                signupCubit.authFormKey.currentState!.save();
                              },
                              title: "التالي",
                            ),

                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "ليس لديك حساب؟",
                                style: const TextStyle(
                                  color: AppColorsLight.secondary,
                                  fontSize: 12,
                                  fontFamily: FONT_FAMILY_CAIRO,
                                ),
                                children: [
                                  const TextSpan(text: ' ؟ '),
                                  TextSpan(
                                    text: "تسجيل الدخول",
                                    style: const TextStyle(
                                      color: AppColorsLight.primary,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: FONT_FAMILY_CAIRO,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRoutes.signinScreen,
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).viewInsets.bottom > 0
                                  ? 0
                                  : PADDING_BOTTOM,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
