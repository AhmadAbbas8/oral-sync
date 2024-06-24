import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._();

  static void setListeners() {
    FirebaseMessaging.instance.getToken().then((token) => _logToken(token));
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  static Future<void> _onBackgroundMessage(RemoteMessage message) async {}

  static void _onMessageOpenedApp(RemoteMessage message) {}

  static void _logToken(String? token) {
    if (kDebugMode) {
      log('🔥💬 FCM Token: $token');
    }
  }
}
