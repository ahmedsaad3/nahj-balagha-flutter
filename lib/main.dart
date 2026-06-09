import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nahj_balagha_flutter/core/services/cache_helper.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/theme_data/theme_data_light.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_cubit.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/controller/navigation_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:nahj_balagha_flutter/features/search/presentation/controller/search_cubit.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/settings_cubit/settings_cubit.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/settings_cubit/settings_state.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/controller/book_cubit.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/controller/scholar_cubit.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/controller/browse_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/favorites/presentation/controller/favorite_cubit.dart';
import 'package:nahj_balagha_flutter/firebase/firebase_notification_service.dart';
import 'package:nahj_balagha_flutter/l10n/app_localizations.dart';
import 'package:nahj_balagha_flutter/l10n/l10n.dart';
import 'package:nahj_balagha_flutter/shared/components/no_internet_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';
import 'package:nahj_balagha_flutter/shared/cubit/connectivity/connectivity_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  ServicesLocator().init();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  CacheHelper.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      // const MyApp()
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => sl<AuthCubit>()..checkAuthenticationStatus(),
          ),
          BlocProvider<SettingsCubit>(create: (context) => sl<SettingsCubit>()),
          BlocProvider<NavigationCubit>(
            create: (context) => sl<NavigationCubit>(),
          ),
          BlocProvider<SearchCubit>(create: (context) => sl<SearchCubit>()),
          BlocProvider<HomeCubit>(create: (context) => sl<HomeCubit>()),
          BlocProvider<BookCubit>(create: (context) => sl<BookCubit>()),
          BlocProvider<ScholarCubit>(create: (context) => sl<ScholarCubit>()),
          BlocProvider<BrowseCubit>(
            create: (context) => sl<BrowseCubit>()..loadBrowseData(),
          ),
          BlocProvider<ContentCubit>(
            create: (context) => sl<ContentCubit>(),
          ),
          BlocProvider<FavoriteCubit>(
            create: (context) => sl<FavoriteCubit>()..getFavorites(),
          ),
          BlocProvider<ConnectivityCubit>(
            create: (context) => sl<ConnectivityCubit>(),
          ),
        ],
        child: DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) {
            return const MyApp();
          },
        ),
      ),
    ),
  );

  // Initialize notifications after main completes to avoid blocking app startup
  // _initializeNotifications();
}

Future<void> _initializeNotifications() async {
  try {
    final notificationService = sl<FirebaseNotificationService>();
    await notificationService.initialize();
    // await notificationService.subscribeToTopic("all");

    // Also handle initial language topic subscription
    final settingsCubit = sl<SettingsCubit>();
    final currentLanguageCode = settingsCubit.state.locale?.languageCode;
    await notificationService.handleLanguageTopicSubscription(
      currentLanguageCode,
    );
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing notifications after main: $e');
    }
  }
}

class MyApp extends StatelessWidget {
  // final String initialRoute;

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      SettingsCubit,
      SettingsState,
      ({ThemeMode theme, Locale? locale})
    >(
      selector: (state) {
        return (theme: state.themeMode, locale: state.locale);
      },
      builder: (context, data) {
        return MaterialApp(
          navigatorKey: AppRoutes.navigatorKey,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,
          locale: Locale('ar'),
          // locale: data.locale,
          supportedLocales: L10n.locals,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: getThemDataLight(),
          themeMode: data.theme,
          home: const OnboardingScreen(),
          // home: BlocBuilder<AuthCubit, AuthState>(
          //   buildWhen: (previous, current) =>
          //       previous.authCheckState != current.authCheckState ||
          //       previous.initialRoute != current.initialRoute,
          //   builder: (context, state) {
          //     if (state.authCheckState == RequestState.loaded) {
          //       if (state.initialRoute == AppRoutes.homeScreen) {
          //         return const NavigationScreen();
          //       } else {
          //         return const WelcomeScreen();
          //       }
          //     }
          //     return const _InitialLoadingWidget();
          //   },
          // ),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          builder: (context, child) {
            return Stack(
              children: [
                child ?? const SizedBox.shrink(),
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: NoInternetWidget(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _InitialLoadingWidget extends StatelessWidget {
  const _InitialLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            // HaydaryaLogoRow(),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            Spacer(),
            TextWidget(title: "جاري التحميل...", fontSize: 16),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
