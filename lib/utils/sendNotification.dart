import 'dart:convert';
import 'dart:developer' as developer show log;
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class SendPushNotification {
  String? fcmToken;


 static  Future<void> sendNotification(String title, String body,/*String adminFcmToken*/) async {
  String adminFcmToken;
   DatabaseReference ref = FirebaseDatabase.instance.ref("admin_token/fcmToken");
   ref.once().then((event) async {
     final dataSnapshot = event.snapshot;

      adminFcmToken = dataSnapshot.value as String; // Treat it as a String
     developer.log("Fetch Token: $adminFcmToken");

     developer.log("To Send Notification: ${adminFcmToken}");
     const String serverKey =
         'AAAAtF0z6yI:APA91bGekbyvzHHvssrkCtcoa2C6aGbOicRqlkYM-yJfvIFQcLhD3kcxUTL7GPsVe_-hDAp0xgCDbDiWMb-iy6sStKx6qEmlGGQMxZ-41iC03GNnaXf9uGpN8cglf_7giX-YKRX4ByJQ';
     const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

     final Map<String, dynamic> notificationData = {
       "registration_ids": [adminFcmToken],
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
       developer.log('Notification sent successfully');
     } else {
       developer.log('Notification sending failed. Status code: ${response.statusCode}');
       developer.log('Response body: ${response.body}');
     }
   });
  }
}
