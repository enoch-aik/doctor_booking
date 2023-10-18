import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  /*static void initialize() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              // channelGroupKey: 'basic_channel_group',
              channelKey: 'noti',
              channelName: 'noti',
              enableVibration: true,importance: NotificationImportance.Max,playSound: true,
              channelDescription: 'Notification channel for basic tests',
              channelShowBadge: true,
              //defaultColor: Color(0xFF9D50DD),
              enableLights: true,
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        */ /*channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'noti',
              channelGroupName: 'noti')
        ],*/ /*
        debug: false);
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    log('==>>>>received noti');
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
onSilentActionHandle(receivedAction);
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
  }

  static Future<void> onSilentActionHandle(ReceivedAction received) async {
    print('On new background action received: ${received.toMap()}');


      SendPort? uiSendPort = IsolateNameServer.lookupPortByName('background_notification_action');
      if (uiSendPort != null) {
        print('Background action running on parallel isolate without valid context. Redirecting execution');
        uiSendPort.send(received);
        return;
    }

    await _handleBackgroundAction(received);
  }

  static Future<void> _handleBackgroundAction(ReceivedAction received) async {
  }*/

  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.denied ||
        settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }
  }

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: DarwinInitializationSettings(requestCriticalPermission: true));
    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      print(payload);
    });
  }

  static void showNotificationOnForeground(RemoteMessage message) {
    const notificationDetail = NotificationDetails(
        android: AndroidNotificationDetails(
          "noti", "noti",
          importance: Importance.max,
          // fullScreenIntent: true,
          playSound: true,
          enableVibration: true,
          priority: Priority.max,
          // sound: RawResourceAndroidNotificationSound('bell_tick'),
          // icon: '@mipmap/ic_launcher',
          // sound: const UriAndroidNotificationSound("assets/bell_tick.wav")
        ),
        iOS: DarwinNotificationDetails(
          presentSound: true,
          presentBadge: true,
          presentAlert: true,
          interruptionLevel: InterruptionLevel.critical,
        ));

    _notificationsPlugin.show(
        DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        notificationDetail,
        payload: message.data["message"]);
  }
}
