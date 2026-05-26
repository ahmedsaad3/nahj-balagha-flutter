import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/auth/data/datasource/base_auth_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/auth/data/repository/auth_repository.dart';
import 'package:nahj_balagha_flutter/features/auth/data/repository/token_repository.dart';
import 'package:nahj_balagha_flutter/features/auth/domain/repository/base_auth_repository.dart';
import 'package:nahj_balagha_flutter/features/auth/domain/repository/base_token_repository.dart';
import 'package:nahj_balagha_flutter/features/auth/domain/usecases/signin_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/domain/usecases/signup_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/domain/usecases/update_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/signin_cubit/signin_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/signup_cubit/signup_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/update_profile_cubit/update_profile_cubit.dart';
import 'package:nahj_balagha_flutter/features/notifications/data/datasource/base_notifications_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/notifications/data/datasource/notifications_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/notifications/data/repository/notifications_repository.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/repository/base_notifications_repository.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/usecases/unsubscribe_from_topic_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/presentation/controller/notifications/notifications_cubit.dart';
import 'package:nahj_balagha_flutter/features/profile/data/datasource/base_profile_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/profile/data/repository/profile_repository.dart';
import 'package:nahj_balagha_flutter/features/profile/domain/repository/base_profile_repository.dart';
import 'package:nahj_balagha_flutter/features/settings/data/datasource/base_settings_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/settings/data/datasource/settings_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/settings/domain/usecases/get_faqs_usecase.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/faqs_cubit/faqs_cubit.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/settings_cubit/settings_cubit.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/controller/navigation_cubit.dart';
import 'package:nahj_balagha_flutter/features/search/presentation/controller/search_cubit.dart';
import 'package:nahj_balagha_flutter/firebase/firebase_notification_service.dart';
import 'package:nahj_balagha_flutter/shared/cubit/connectivity/connectivity_cubit.dart';
import 'package:nahj_balagha_flutter/features/home/data/repository/home_repository_impl.dart';
import 'package:nahj_balagha_flutter/features/home/data/datasource/base_home_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/home/data/datasource/home_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/home/domain/repository/base_home_repository.dart';
import 'package:nahj_balagha_flutter/features/home/domain/usecases/get_home_data_usecase.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_cubit.dart';

import 'package:nahj_balagha_flutter/features/books/data/datasource/base_book_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/books/data/datasource/book_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/books/data/repository/book_repository.dart';
import 'package:nahj_balagha_flutter/features/books/domain/repository/base_book_repository.dart';
import 'package:nahj_balagha_flutter/features/books/domain/usecases/get_articles_usecases.dart';
import 'package:nahj_balagha_flutter/features/books/domain/usecases/get_foreign_studies_usecases.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/controller/book_cubit.dart';

import 'package:nahj_balagha_flutter/features/scholars/data/datasource/base_scholar_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/scholars/data/datasource/scholar_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/scholars/data/repository/scholar_repository.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/repository/base_scholar_repository.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/usecases/get_scholars_usecase.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/controller/scholar_cubit.dart';


final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // ============================================================
    // todo: EXTERNAL DEPENDENCIES
    // ============================================================

    // Flutter Secure Storage
    sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      ),
    );

    // Dio Client
    sl.registerLazySingleton<DioClient>(
      () => DioClient(tokenRepository: sl<TokenRepository>()),
    );

    // Firebase Notification Service
    sl.registerLazySingleton<FirebaseNotificationService>(
      () => FirebaseNotificationService(),
    );

    // ============================================================
    // todo: DATA SOURCES
    // ============================================================

    // Auth Remote Data Source
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
      () => AuthRemoteDataSource(client: sl<DioClient>()),
    );

    // Settings Remote Data Source
    sl.registerLazySingleton<BaseSettingsRemoteDataSource>(
      () => SettingsRemoteDataSource(client: sl<DioClient>()),
    );

    // Notifications Remote Data Source
    sl.registerLazySingleton<BaseNotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSource(client: sl<DioClient>()),
    );

    // Profile Remote Data Source
    sl.registerLazySingleton<BaseProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(client: sl<DioClient>()),
    );

    // Home Remote Data Source
    sl.registerLazySingleton<BaseHomeRemoteDataSource>(
      () => HomeRemoteDataSource(client: sl<DioClient>()),
    );

    // Book Remote Data Source
    sl.registerLazySingleton<BaseBookRemoteDataSource>(
      () => BookRemoteDataSource(client: sl<DioClient>()),
    );

    // Scholar Remote Data Source
    sl.registerLazySingleton<BaseScholarRemoteDataSource>(
      () => ScholarRemoteDataSource(client: sl<DioClient>()),
    );


    // ============================================================
    // todo: REPOSITORIES
    // ============================================================

    // Auth Repository
    sl.registerLazySingleton<BaseAuthRepository>(
      () => AuthRepository(baseAuthRemoteDataSource: sl()),
    );

    // Token Repository
    sl.registerLazySingleton<BaseTokenRepository>(
      () => TokenRepository(sl<FlutterSecureStorage>()),
    );

    sl.registerLazySingleton<TokenRepository>(
      () => sl<BaseTokenRepository>() as TokenRepository,
    );

    // Notifications Repository
    sl.registerLazySingleton<BaseNotificationsRepository>(
      () => NotificationsRepository(baseNotificationsRemoteDataSource: sl()),
    );

    // Profile Repository
    sl.registerLazySingleton<BaseProfileRepository>(
      () => ProfileRepository(baseProfileRemoteDataSource: sl()),
    );

    // Home Repository
    sl.registerLazySingleton<BaseHomeRepository>(
      () => HomeRepositoryImpl(
        homeRemoteDataSource: sl(),
        bookRemoteDataSource: sl(),
        scholarRemoteDataSource: sl(),
      ),
    );

    // Book Repository
    sl.registerLazySingleton<BaseBookRepository>(
      () => BookRepository(baseBookRemoteDataSource: sl()),
    );

    // Scholar Repository
    sl.registerLazySingleton<BaseScholarRepository>(
      () => ScholarRepository(baseScholarRemoteDataSource: sl()),
    );


    // ============================================================
    // todo: USE CASES
    // ============================================================

    // Auth Use Cases
    sl.registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(baseAuthRepository: sl()),
    );

    // Signin Use Case
    sl.registerLazySingleton<SigninUseCase>(
      () => SigninUseCase(baseAuthRepository: sl()),
    );

    // Update Use Case
    sl.registerLazySingleton<UpdateUseCase>(
      () => UpdateUseCase(baseAuthRepository: sl()),
    );

    // Settings Use Cases
    sl.registerLazySingleton<GetFAQsUseCase>(
      () => GetFAQsUseCase(baseSettingsRepository: sl()),
    );

    // Notifications Use Cases
    sl.registerLazySingleton<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(baseNotificationsRepository: sl()),
    );

    // Subscribe To Topic Use Case
    sl.registerLazySingleton<SubscribeToTopicUseCase>(
      () => SubscribeToTopicUseCase(baseNotificationsRepository: sl()),
    );

    // Unsubscribe From Topic Use Case
    sl.registerLazySingleton<UnsubscribeFromTopicUseCase>(
      () => UnsubscribeFromTopicUseCase(baseNotificationsRepository: sl()),
    );

    // Home Use Case
    sl.registerLazySingleton<GetHomeDataUseCase>(
      () => GetHomeDataUseCase(baseHomeRepository: sl()),
    );

    // Book Use Cases
    sl.registerLazySingleton<GetArticlesUseCases>(
      () => GetArticlesUseCases(baseBookRepository: sl()),
    );
    sl.registerLazySingleton<GetForeignStudiesUseCases>(
      () => GetForeignStudiesUseCases(baseBookRepository: sl()),
    );

    // Scholar Use Case
    sl.registerLazySingleton<GetScholarsUseCase>(
      () => GetScholarsUseCase(baseScholarRepository: sl()),
    );


    // ============================================================
    // todo: PRESENTATION LAYER (CUBITS)
    // ============================================================

    // Auth Cubits
    sl.registerLazySingleton<AuthCubit>(
      () => AuthCubit(tokenRepository: sl<TokenRepository>()),
    );

    sl.registerFactory<SigninCubit>(
      () => SigninCubit(
        signinUseCase: sl<SigninUseCase>(),
        tokenRepository: sl<TokenRepository>(),
      ),
    );

    sl.registerFactory<SignupCubit>(
      () => SignupCubit(
        signupUseCase: sl<SignupUseCase>(),
        tokenRepository: sl<TokenRepository>(),
      ),
    );

    sl.registerFactory<UpdateProfileCubit>(
      () => UpdateProfileCubit(
        updateUseCase: sl<UpdateUseCase>(),
        tokenRepository: sl<TokenRepository>(),
      ),
    );

    // Settings Cubits
    sl.registerFactory<SettingsCubit>(() => SettingsCubit());

    // FAQs Cubit
    sl.registerFactory<FAQsCubit>(
      () => FAQsCubit(qetFAQsUseCase: sl<GetFAQsUseCase>()),
    );

    // Notifications Cubit
    sl.registerFactory<NotificationsCubit>(
      () => NotificationsCubit(
        getNotificationsUseCase: sl<GetNotificationsUseCase>(),
        subscribeToTopicUseCase: sl<SubscribeToTopicUseCase>(),
        unsubscribeFromTopicUseCase: sl<UnsubscribeFromTopicUseCase>(),
      ),
    );

    // Navigation Cubit
    sl.registerFactory<NavigationCubit>(() => NavigationCubit());

    // Search Cubit
    sl.registerFactory<SearchCubit>(() => SearchCubit());

    // Home Cubit
    sl.registerFactory<HomeCubit>(
      () => HomeCubit(getHomeDataUseCase: sl()),
    );

    // Book Cubit
    sl.registerFactory<BookCubit>(
      () => BookCubit(
        getArticlesUseCases: sl(),
        getForeignStudiesUseCases: sl(),
      ),
    );

    // Scholar Cubit
    sl.registerFactory<ScholarCubit>(
      () => ScholarCubit(sl()),
    );


    // Connectivity Cubit (Singleton for app-wide connectivity state)
    sl.registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit());
  }
}
