import 'dart:convert';

import 'package:http/http.dart' as http;

class SendPushNotification {
  static Future<void> sendNotification(String title, String body) async {
    const String serverKey =
        'AAAAtF0z6yI:APA91bGekbyvzHHvssrkCtcoa2C6aGbOicRqlkYM-yJfvIFQcLhD3kcxUTL7GPsVe_-hDAp0xgCDbDiWMb-iy6sStKx6qEmlGGQMxZ-41iC03GNnaXf9uGpN8cglf_7giX-YKRX4ByJQ';
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> notificationData = {
      "registration_ids": [
        "eIId6N1-QIyExKZuQkJWRc:APA91bFATsgT3BfHT5fm2NnU9EnpFqLF5yYHiUpqFuZmfmIcvsBwxdRh0B4t9dDQwD_1ROfWMVKLXWXMJnM5r0ejF_GCv0GVwxft0K1ylxdvWnRr2QwwBTsMsF4X6QlWueT4t7EQNXaF"
      ],
      "notification": {
        "body": body,
        "title": title,
        "android_channel_id": "adminNotificationChannel",
        "sound": true
      },
      "data": {"_id": 1}
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final http.Response response = await http.post(
      Uri.parse(fcmUrl),
      headers: headers,
      body: json.encode(notificationData),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Notification sending failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
