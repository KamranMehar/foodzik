import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer' as developer show log;

import 'package:foodzik/admin%20pages/customer_order_screen/customer_order_screen.dart';
import 'package:foodzik/pages/login_page.dart';
import 'package:foodzik/pages/main_screen.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? id) async {
        developer.log("onSelectNotification");
        if (id!.isNotEmpty) {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const CustomerOrderScreen();
          }));
        /*  developer.log("Router Value1234 $id");
          if(id.contains("Admin")){
            developer.log("Notification for admin");

           // Navigator.pushNamed(context,'/customerOrderScreen' );
          }*/
        }else{
          if(FirebaseAuth.instance.currentUser!=null){
            Navigator.push(context, MaterialPageRoute(builder: (context){
             return const MainScreen();
            }));
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context){
             return const LoginPage();
            }));
          }
        }
      },
    );
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "foodzik",
          "adminNotificationChannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

}