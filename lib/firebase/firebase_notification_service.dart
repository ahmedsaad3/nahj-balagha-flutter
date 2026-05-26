import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Background message handler - must be a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Handling a background message: ${message.messageId}');
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
  }
}

/// Firebase Cloud Messaging Service
/// Handles notification configuration, token management, and topic subscriptions
class FirebaseNotificationService {
  static final FirebaseNotificationService _instance =
      FirebaseNotificationService._internal();

  factory FirebaseNotificationService() => _instance;

  FirebaseNotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Stream controllers for notifications
  final StreamController<RemoteMessage> _messageStreamController =
      StreamController<RemoteMessage>.broadcast();
  final StreamController<String?> _tokenStreamController =
      StreamController<String?>.broadcast();

  /// Stream of foreground messages
  Stream<RemoteMessage> get onMessage => _messageStreamController.stream;

  /// Stream of FCM token updates
  Stream<String?> get onTokenRefresh => _tokenStreamController.stream;

  static const List<String> _languageTopics = ['lang_ar', 'lang_en', 'lang_fa'];

  String? _currentToken;

  /// Get the current FCM token
  String? get currentToken => _currentToken;

  /// Get the Firebase Notification Token (FCM token)
  /// This can be called from anywhere to get the token, ensuring the service is initialized if possible.
  static Future<String?> getNotificationToken() async {
    try {
      final service = FirebaseNotificationService();
      if (service._currentToken != null) {
        return service._currentToken;
      }
      return await service._getToken();
    } catch (e) {
      if (kDebugMode) {
        print('Error in getNotificationToken: $e');
      }
      return null;
    }
  }

  /// Initialize Firebase Cloud Messaging
  /// Returns the FCM token if successful
  Future<String?> initialize() async {
    try {
      // Request permission for iOS
      NotificationSettings settings = await _requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        if (kDebugMode) {
          print('User granted notification permission');
        }

        // Get the FCM token
        _currentToken = await _getToken();

        // Configure foreground notification presentation options
        await _configureForegroundNotifications();

        // Listen to token refresh
        _listenToTokenRefresh();

        // Listen to foreground messages
        _listenToForegroundMessages();

        // Listen to background messages
        FirebaseMessaging.onBackgroundMessage(
          firebaseMessagingBackgroundHandler,
        );

        // Handle notification taps when app is in background or terminated
        _handleNotificationTaps();

        if (kDebugMode) {
          print('Firebase Messaging initialized successfully');
          print('FCM Token: $_currentToken');
        }

        return _currentToken;
      } else {
        if (kDebugMode) {
          print('User declined or has not accepted notification permission');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing Firebase Messaging: $e');
      }
      return null;
    }
  }

  /// Request notification permissions (iOS)
  Future<NotificationSettings> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('Notification permission status: ${settings.authorizationStatus}');
    }

    return settings;
  }

  /// Get FCM token
  Future<String?> _getToken() async {
    try {
      String? token;
      if (Platform.isIOS) {
        // For iOS, get APNs token first
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null) {
          token = await _firebaseMessaging.getToken();
        } else {
          if (kDebugMode) {
            print('APNs token not available yet');
          }
          // Retry after a delay
          await Future.delayed(const Duration(seconds: 3));
          token = await _firebaseMessaging.getToken();
        }
      } else {
        token = await _firebaseMessaging.getToken();
      }

      if (kDebugMode) {
        print('FCM Token obtained: $token');
      }

      return token;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting FCM token: $e');
      }
      return null;
    }
  }

  /// Configure how notifications are presented when app is in foreground
  Future<void> _configureForegroundNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Listen to token refresh events
  void _listenToTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      if (kDebugMode) {
        print('FCM Token refreshed: $newToken');
      }
      _currentToken = newToken;
      _tokenStreamController.add(newToken);
    });
  }

  /// Listen to foreground messages
  void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Received foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        if (message.notification != null) {
          print('Message notification title: ${message.notification!.title}');
          print('Message notification body: ${message.notification!.body}');
        }
      }
      _messageStreamController.add(message);
    });
  }

  /// Handle notification taps
  void _handleNotificationTaps() {
    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Notification tapped (app in background): ${message.messageId}');
        print('Message data: ${message.data}');
      }
      // Handle navigation based on message data
      _handleNotificationNavigation(message);
    });

    // Check if app was opened from a terminated state via notification
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if (kDebugMode) {
          print('Notification tapped (app terminated): ${message.messageId}');
          print('Message data: ${message.data}');
        }
        // Handle navigation based on message data
        _handleNotificationNavigation(message);
      }
    });
  }

  /// Handle navigation based on notification data
  void _handleNotificationNavigation(RemoteMessage message) {
    // Implement your navigation logic here based on message.data
    // Example:
    // if (message.data.containsKey('screen')) {
    //   String screen = message.data['screen'];
    //   // Navigate to the specified screen
    // }
  }

  /// Subscribe to a topic
  /// Returns true if successful, false otherwise
  Future<bool> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      if (kDebugMode) {
        print('Successfully subscribed to topic: $topic');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error subscribing to topic $topic: $e');
      }
      return false;
    }
  }

  /// Unsubscribe from a topic
  /// Returns true if successful, false otherwise
  Future<bool> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      if (kDebugMode) {
        print('Successfully unsubscribed from topic: $topic');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error unsubscribing from topic $topic: $e');
      }
      return false;
    }
  }

  /// Handle language topic subscription based on language code
  /// Unsubscribes from all language topics and subscribes to the new one
  Future<void> handleLanguageTopicSubscription(String? languageCode) async {
    try {
      // Unsubscribe from all known language topics first to ensure only one is active
      for (final topic in _languageTopics) {
        await unsubscribeFromTopic(topic);
      }

      String? targetTopic;

      if (languageCode == null || languageCode == 'system') {
        // If system, try to get the platform language
        final String systemLanguage =
            PlatformDispatcher.instance.locale.languageCode;
        if (_languageTopics.contains('lang_$systemLanguage')) {
          targetTopic = 'lang_$systemLanguage';
        }
      } else if (_languageTopics.contains('lang_$languageCode')) {
        targetTopic = 'lang_$languageCode';
      }

      if (targetTopic != null) {
        await subscribeToTopic(targetTopic);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error handling language topic subscription: $e');
      }
    }
  }

  /// Delete the FCM token
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _currentToken = null;
      if (kDebugMode) {
        print('FCM token deleted successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting FCM token: $e');
      }
    }
  }

  /// Get notification settings
  Future<NotificationSettings> getNotificationSettings() async {
    return await _firebaseMessaging.getNotificationSettings();
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    NotificationSettings settings = await getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  /// Dispose streams
  void dispose() {
    _messageStreamController.close();
    _tokenStreamController.close();
  }
}
