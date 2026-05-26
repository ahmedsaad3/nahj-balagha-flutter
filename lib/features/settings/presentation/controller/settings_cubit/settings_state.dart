import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final bool themeModeSwitchOn;
  final Locale? locale;
  const SettingsState({
    this.themeMode = ThemeMode.light,
    this.themeModeSwitchOn = false,
    this.locale,
  });

  @override
  List<Object?> get props => [themeMode, themeModeSwitchOn, locale];

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? themeModeSwitchOn,
    Locale? locale,
    bool setLocaleNull = false,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      themeModeSwitchOn: themeModeSwitchOn ?? this.themeModeSwitchOn,
      locale: setLocaleNull ? null : (locale ?? this.locale),
    );
  }
}
