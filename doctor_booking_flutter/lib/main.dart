import 'package:doctor_booking_flutter/app.dart';
import 'package:doctor_booking_flutter/core/di/di_providers.dart';
import 'package:doctor_booking_flutter/core/services/storage/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/notification.dart';
import 'firebase_options.dart';

//background notification handler
@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await notificationsPlugin.show(
      1,
      'noti',
      'noti',
      const NotificationDetails(
          android: AndroidNotificationDetails('noti', 'noti',
              priority: Priority.max,
              importance: Importance.max,
              enableVibration: true,
              // sound: RawResourceAndroidNotificationSound('bell_tick'),
              // icon: '@mipmap/ic_launcher',
              channelDescription: 'noti')));
}

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //init sharedPreferences
  prefs = await SharedPreferences.getInstance();
  //set app orientation to only portrait view
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Initialize FirebaseApp and FirebaseAuth into app
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);

  // handle background notification
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  //initialize notification service and check for initial message, background message and foreground message
  NotificationService.initialize();
  await NotificationService.requestPermission();
  await initialMessage();
  await messageOpened();
  onMessage();
  //run app
  runApp(ProviderScope(
    overrides: [
      firebaseAppProvider.overrideWith((ref) => app),
      firebaseAuthProvider.overrideWith((ref) => auth)
    ],
    child: const DoctorBookingApp(),
  ));
}

void onMessage() {
  FirebaseMessaging.onMessage.listen((event) {
    NotificationService.showNotificationOnForeground(event);
    print(
        '${event.notification!.title} ${event.notification!.body} I am coming from foreground');
  });
}

Future<void> initialMessage() async {
  // Terminated State
  await FirebaseMessaging.instance.getInitialMessage().then((event) {
    if (event != null) {
      print(
          "${event.notification!.title} ${event.notification!.body} I am coming from terminated state");
    }
  });
}

Future<void> messageOpened() async {
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(
        "${event.notification!.title} ${event.notification!.body} I am coming from background");
  });
}
