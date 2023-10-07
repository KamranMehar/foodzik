import 'dart:developer' as developer show log;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:foodzik/pages/home/home_page.dart';
import 'package:foodzik/const/colors.dart';
import '../notificationservice/notificationservice.dart';
import 'drawer/my_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: greenPrimary,
      body: ZoomDrawer(
        androidCloseOnBackTap: true,
        isRtl: true,
        menuScreen:  MyDrawer(),
        mainScreen: const HomePage(),
        showShadow: true,
        style: DrawerStyle.defaultStyle,
        drawerShadowsBackgroundColor: greenPrimary,
        borderRadius: 35,
        mainScreenTapClose: true,
        slideWidth:  MediaQuery.of(context).size.width * 0.65,
        angle: 0.0,//180*(pi/180.0),
      ),
    );
  }


  @override
  void initState() {
    super.initState();

// 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        developer.log("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          developer.log("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        developer.log("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          developer.log(message.notification!.title.toString());
          developer.log(message.notification!.body.toString());
          developer.log("message.data11 ${message.data}");
           LocalNotificationService.createAndDisplayNotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        developer.log("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          developer.log(message.notification!.title.toString());
          developer.log(message.notification!.body.toString());
          developer.log("message.data22 ${message.data['_id']}");
        }
      },
    );
  }
}
