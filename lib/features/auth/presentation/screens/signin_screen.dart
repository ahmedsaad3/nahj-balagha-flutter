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
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/signin_cubit/signin_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/signin_cubit/signin_state.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/controller/navigation_cubit.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/input_field_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SigninCubit>()..initControllers(),
      child: const _SigninScreenContent(),
    );
  }
}

class _SigninScreenContent extends StatelessWidget {
  const _SigninScreenContent();

  @override
  Widget build(BuildContext context) {
    final SigninCubit signinCubit = context.read<SigninCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: UiUtils.appBar(
        context: context,
        backIconColor: AppColorsLight.black,
        backgroundColor: AppColorsLight.white,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: signinCubit.authFormKey,
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            const SizedBox(width: HORIZONTAL),
                            TextWidget(
                              title: "تسجيل الدخول",
                              fontSize: 16,
                              color: AppColorsLight.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            BlocSelector<
                              SigninCubit,
                              SigninState,
                              ({bool showPassword, bool readOnly})
                            >(
                              selector: (state) {
                                return (
                                  showPassword: state.showPassword,
                                  readOnly:
                                      state.signinState == RequestState.loading,
                                );
                              },
                              builder: (context, data) {
                                return Column(
                                  spacing: 14,
                                  children: [
                                    PhoneInputFieldWidget(
                                      controller:
                                          signinCubit.phoneNumberController,
                                      enabled: !data.readOnly,
                                      onCountryChanged: (country) {
                                        signinCubit
                                            .phoneNumberTypeController
                                            .text = country.dialCode
                                            .toString();
                                      },
                                      onPhoneNumberChanged: (fullNumber) {
                                        signinCubit.phoneNumberController.text =
                                            fullNumber ?? "";
                                        return;
                                      },
                                    ),
                                    InputFieldWidget(
                                      title: "كلمة المرور",
                                      hintText:
                                          "كلمة المرور",
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      controller:
                                          signinCubit.passwordController,
                                      enableShowPassword: true,
                                      enabled: !data.readOnly,
                                      showPassword: !data.showPassword,
                                      onPressedShowPassword:
                                          signinCubit.togglePasswordVisibility,
                                      valid: (value) {
                                        return UiUtils.validatePassword(
                                          value: value,
                                          context: context,
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        BlocListener<SigninCubit, SigninState>(
                          listenWhen: (previous, current) =>
                              previous.signinState != current.signinState,
                          listener: (context, state) {
                            if (state.signinState == RequestState.loaded) {
                              UiUtils.toastMessage(
                                context: context,
                                message: "تم تسجيل الدخول بنجاح",
                                backgroundColor: Colors.green,
                              );
                              context.read<AuthCubit>().updateUser(state.user);
                              context
                                  .read<NavigationCubit>()
                                  .updateSelectedIndex();
                              // Navigator.pushNamedAndRemoveUntil(
                              //   context,
                              //   AppRoutes.homeScreen,
                              //   (route) => false,
                              // );
                            }
                            if (state.signinState == RequestState.error) {
                              UiUtils.toastMessage(
                                context: context,
                                message: state.signinMessage,
                                backgroundColor: Colors.redAccent,
                              );
                            }
                          },
                          child: const SizedBox.shrink(),
                        ),
                        Column(
                          spacing: 12,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BlocSelector<SigninCubit, SigninState, bool>(
                              selector: (state) {
                                return state.signinState ==
                                    RequestState.loading;
                              },
                              builder: (context, isLoading) {
                                return ElevatedButtonWidget(
                                  isLoading: isLoading,
                                  onPressed: () async {
                                    await signinCubit.signin();
                                  },
                                  title: "تسجيل الدخول",
                                );
                              },
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text:  TextSpan(
                                text: "ليس لديك حساب؟",
                                style: TextStyle(
                                  color: AppColorsLight.secondary,
                                  fontSize: 12,
                                  fontFamily: FONT_FAMILY_CAIRO,
                                ),
                                children: [
                                  const TextSpan(text: ' ؟ '),
                                  TextSpan(
                                    text: "إنشاء حساب",
                                    style: const TextStyle(
                                      color: AppColorsLight.primary,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: FONT_FAMILY_CAIRO,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRoutes.signupScreen,
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
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
