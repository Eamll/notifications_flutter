//SHA1 98:30:D2:B5:69:83:35:E2:DB:CE:07:4F:CE:DF:2F:13:38:B1:6D:A7

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  // ignore: prefer_final_fields
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _onBackgroundHandler(RemoteMessage message) async {
    // print('background handler: ${message.messageId}');
    print(message.data);
    // _messageStream.add(message.notification?.title ?? 'No tittle');
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('background handler: ${message.messageId}');
    print(message.data);
    // _messageStream.add(message.notification?.title ?? 'No tittle');
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print(message.data);
    // print('background handler: ${message.messageId}');
    // _messageStream.add(message.notification?.title ?? 'No tittle');
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  static Future initializeApp() async {
    //Push Notifications
    await Firebase.initializeApp();
    await messaging.getInitialMessage();
    // await requestPermission();
    token = await FirebaseMessaging.instance.getToken();
    print(token);
    //Handlers
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local Notifications
  }

  static closeStreams() {
    _messageStream.close();
  }
}
