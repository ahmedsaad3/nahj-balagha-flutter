import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/settings_cubit/settings_state.dart';
import 'package:nahj_balagha_flutter/firebase/firebase_notification_service.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleThemeMode() {
    if (state.themeMode == ThemeMode.light) {
      emit(state.copyWith(themeMode: ThemeMode.dark));
      emit(state.copyWith(themeModeSwitchOn: true));
      return;
    }
    emit(state.copyWith(themeMode: ThemeMode.light));
    emit(state.copyWith(themeModeSwitchOn: false));
    return;
  }

  void changeLanguage({required String? languageCode}) {
    if (languageCode == null || languageCode == 'system') {
      emit(state.copyWith(setLocaleNull: true));
    } else {
      emit(state.copyWith(locale: Locale(languageCode)));
    }
    sl<FirebaseNotificationService>().handleLanguageTopicSubscription(
      languageCode,
    );
  }
}
