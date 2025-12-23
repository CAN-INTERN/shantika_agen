import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

/// Background message handler - harus di top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('📨 Background message: ${message.notification?.title}');
}

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  String? _fcmToken; // ⭐ Simpan token
  String? get fcmToken => _fcmToken; // ⭐ Getter untuk akses token

  /// Initialize FCM
  Future<void> initialize() async {
    try {
      // Request permission
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      print('📱 Permission: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Initialize local notifications
        await _initLocalNotifications();

        // ⭐ Get token saat initialize
        await getToken();

        // Setup handlers
        _setupHandlers();

        // Background handler
        FirebaseMessaging.onBackgroundMessage(
            firebaseMessagingBackgroundHandler
        );

        print('✅ FCM initialized successfully');
      }
    } catch (e) {
      print('❌ FCM init error: $e');
    }
  }

  /// Initialize local notifications
  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Android channel
    const channel = AndroidNotificationChannel(
      'shantika_channel',
      'Shantika Notifications',
      description: 'Notifikasi dari New Shantika',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Setup message handlers
  void _setupHandlers() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      print('📬 Foreground: ${message.notification?.title}');
      _showNotification(message);
    });

    // Background tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('🔔 Opened from background');
      _handleNotificationTap(message.data);
    });

    // Terminated tap
    _messaging.getInitialMessage().then((message) {
      if (message != null) {
        print('🚀 Opened from terminated');
        _handleNotificationTap(message.data);
      }
    });
  }

  /// Show notification when app is in foreground
  Future<void> _showNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'shantika_channel',
      'Shantika Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'Notifikasi Baru',
      message.notification?.body ?? '',
      details,
      payload: jsonEncode(message.data),
    );
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      _handleNotificationTap(data);
    }
  }

  /// Navigate based on notification type
  void _handleNotificationTap(Map<String, dynamic> data) {
    print('📍 Notification data: $data');

    // TODO: Implement navigation
    // Example:
    // final type = data['type'];
    // if (type == 'ORDER') {
    //   navigatorKey.currentState?.pushNamed('/order-detail', arguments: data);
    // }
  }

  /// Get FCM token
  Future<String?> getToken() async {
    try {
      _fcmToken = await _messaging.getToken(); // ⭐ Save token
      print('🔔 FCM Token: $_fcmToken');

      // ⭐ Listen to token refresh
      _messaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        print('🔄 Token refreshed: $newToken');
      });

      return _fcmToken;
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  /// Delete token (saat logout)
  Future<void> deleteToken() async {
    try {
      await _messaging.deleteToken();
      _fcmToken = null; // ⭐ Clear token
      print('✅ FCM token deleted');
    } catch (e) {
      print('Error deleting token: $e');
    }
  }
}