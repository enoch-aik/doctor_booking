/// using [Dio] for http requests but since this is very basic and I am going to be only making one call
/// it is going to be very basic

import 'dart:io';

import 'package:dio/dio.dart';

class FCMService {
  final String serverKey;

  FCMService({required this.serverKey}) {
    _dio = Dio(BaseOptions(
      baseUrl: _fcmEndpoint,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'key=$serverKey',
      },
    ));
  }

  final String _fcmEndpoint = "https://fcm.googleapis.com/fcm/";

  final String _channelId = 'noti';
  late final Dio _dio;

  Future<bool> sendNotification(
      {required String recipientFCMToken,
      required String title,
      required String body}) async {
    try {
      await _dio.post('send', data: {
        // "registration_ids": [recipientFCMToken],
        "priority": "high",
        "notification": {
          "title": title,
          "body": body,
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        "channel_id": _channelId,
        'to': recipientFCMToken,
      });

      return true;
    } catch (_) {
      return false;
    }
  }
}
