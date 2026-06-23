import 'package:flutter/material.dart';

import 'package:nahj_balagha_flutter/features/auth/presentation/screens/signin_screen.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/screens/signup_screen.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/screens/browse_screen.dart';
import 'package:nahj_balagha_flutter/features/favorites/presentation/screens/favorite_screen.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/screens/home_screen.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/screens/book_details_screen.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/screen/navigation_screen.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/screens/scholar_details_screen.dart';
import 'package:nahj_balagha_flutter/features/notifications/presentation/screens/notificationss_screen.dart';
import 'package:nahj_balagha_flutter/features/profile/presentation/screens/profile_screen.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/screens/scholars_screen.dart';
import 'package:nahj_balagha_flutter/features/search/presentation/screens/search_screen.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/screens/faqs_screen.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/screens/settings_screen.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/screens/category_screen.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/screens/content_reader_screen.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/scholar_explanation_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/screens/full_explanation_screen.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // todo: Navigation
  static const String navigationScreen = "navigation_screen";

  // todo: Auth
  static const String welcomeScreen = "welcome_screen";
  static const String onboardingScreen = "onboarding_screen";
  static const String signupScreen = "signup_screen";
  static const String signinScreen = "signin_screen";

  // todo: Settings
  static const String settingsScreen = "settings_screen";
  static const String faqsScreen = "faqs_screen";

  // todo: Profile
  static const String profileScreen = "profile_screen";

  // todo: Notifications
  static const String notificationsScreen = "notifications_screen";

  // todo: Home
  static const String homeScreen = "home_screen";
  static const String bookDetailsScreen = "book_details_screen";

  // todo: Scholars
  static const String scholarDetailsScreen = "scholar_details_screen";
  static const String scholarsScreen = "scholars_screen";

  // todo: Search
  static const String searchScreen = "search_screen";

  // todo: Favorites
  static const String favoritesScreen = "favorites_screen";

  // todo: Browse
  static const String browseScreen = "browse_screen";
  static const String categoryScreen = "category_screen";
  static const String contentReaderScreen = "content_reader_screen";
  static const String fullExplanationScreen = "full_explanation_screen";

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case navigationScreen:
        return MaterialPageRoute(builder: (_) => const NavigationScreen());

      case onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case scholarsScreen:
        return MaterialPageRoute(builder: (_) => const ScholarsScreen());

      case scholarDetailsScreen:
        final scholar = settings.arguments as ScholarEntity;
        return MaterialPageRoute(
          builder: (_) => ScholarDetailsScreen(scholar: scholar),
        );

      case bookDetailsScreen:
        final book = settings.arguments as BookEntity;
        return MaterialPageRoute(builder: (_) => BookDetailsScreen(book: book));

      case signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case signinScreen:
        return MaterialPageRoute(builder: (_) => const SigninScreen());

      case settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case faqsScreen:
        return MaterialPageRoute(builder: (_) => const FAQsScreen());

      case profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case notificationsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case favoritesScreen:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());

      case browseScreen:
        return MaterialPageRoute(builder: (_) => const BrowseScreen());

      case categoryScreen:
        final path = settings.arguments as List<BrowseNode>;
        return MaterialPageRoute(builder: (_) => CategoryScreen(trail: path));

      case contentReaderScreen:
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          final contentId = args['contentId'] as String;
          final trail = args['trail'] as List<BrowseNode>;
          return MaterialPageRoute(
            builder: (_) =>
                ContentReaderScreen(contentId: contentId, trail: trail),
          );
        } else {
          final contentId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => ContentReaderScreen(contentId: contentId),
          );
        }

      case fullExplanationScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final initialExplanation =
            args['initialExplanation'] as ScholarExplanationEntity;
        final explanations =
            args['explanations'] as List<ScholarExplanationEntity>;
        final isComparing = args['isComparing'] as bool? ?? false;
        final selectedIds = args['selectedIds'] as List<String>? ?? const [];
        return MaterialPageRoute(
          builder: (_) => FullExplanationScreen(
            initialExplanation: initialExplanation,
            explanations: explanations,
            isComparing: isComparing,
            selectedIds: selectedIds,
          ),
        );
    }
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Route not found'))),
    );
  }
}
