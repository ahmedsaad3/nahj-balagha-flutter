import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';

ThemeData getThemDataLight() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColorsLight.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColorsLight.primary,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 18,
      color: AppColorsLight.white,
      fontWeight: FontWeight.bold,
    ),
    scrolledUnderElevation: 0,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry?>((
        Set<WidgetState> states,
      ) {
        return EdgeInsets.zero;
      }),

      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed)) {
          return AppColorsLight.buttonSecondary.withAlpha(50);
        }
        return null;
      }),

      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColorsLight.buttonPrimary.withAlpha(60);
        }
        return AppColorsLight.buttonPrimary;
      }),
      elevation: WidgetStateProperty.resolveWith<double?>((states) {
        return 0;
      }),
    ),
  ),

  textTheme: const TextTheme(
    titleSmall: TextStyle(color: AppColorsLight.textPrimary),
    bodyMedium: TextStyle(color: AppColorsLight.textPrimary),
    bodySmall: TextStyle(color: AppColorsLight.textPrimary),
  ),

  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColorsLight.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RADIUS),
      borderSide: const BorderSide(color: AppColorsLight.gray, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RADIUS),
      borderSide: const BorderSide(color: AppColorsLight.secondary, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RADIUS),
      borderSide: const BorderSide(color: AppColorsLight.gray, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RADIUS),
      borderSide: const BorderSide(color: AppColorsLight.red, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RADIUS),
      borderSide: const BorderSide(color: AppColorsLight.red, width: 1),
    ),
    hintStyle: TextStyle(
      color: AppColorsLight.gray,
      fontSize: 12,
      fontFamily: FONT_FAMILY_CAIRO,
    ),
    errorStyle: const TextStyle(fontFamily: FONT_FAMILY_CAIRO, fontSize: 10),
    errorMaxLines: 1,
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColorsLight.white,
  ),

  dialogTheme: const DialogThemeData(backgroundColor: AppColorsLight.white),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColorsLight.white,
    type: BottomNavigationBarType.fixed,
    landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    selectedItemColor: AppColorsLight.secondary,
    unselectedItemColor: AppColorsLight.gray,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(fontSize: 12, fontFamily: FONT_FAMILY_CAIRO),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
      fontFamily: FONT_FAMILY_CAIRO,
    ),
    elevation: 10.0,
  ),

  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(RADIUS),
      side: BorderSide.none,
    ),
    color: AppColorsLight.white,
    elevation: 0,
  ),

  colorScheme: const ColorScheme.light(
    primary: AppColorsLight.primary,
    secondary: AppColorsLight.secondary,
    surface: AppColorsLight.white,
    onPrimary: AppColorsLight.white,
    onSecondary: AppColorsLight.textPrimary,
    onSurface: AppColorsLight.textPrimary,
  ),

  tabBarTheme: TabBarThemeData(
    unselectedLabelColor: AppColorsLight.primary,
    labelColor: AppColorsLight.primary,
    indicatorColor: AppColorsLight.accent,
    labelStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: FONT_FAMILY_CAIRO,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: FONT_FAMILY_CAIRO,
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
    labelPadding: EdgeInsets.zero,
    splashBorderRadius: const BorderRadius.all(Radius.circular(RADIUS)),
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  ),
);
