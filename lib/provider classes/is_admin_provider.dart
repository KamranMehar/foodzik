import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer'as developer show log;

import 'package:foodzik/const/catefories_list.dart';

class IsAdminProvider with ChangeNotifier {
  bool _isAdmin = false;
  String? _fcmToken;
  String? _adminUid;
  IsAdminProvider() {
    checkUserIsAdmin(); // Call the function here
  }

  String? get fcmToken => _fcmToken;

  String? get adminUid => _adminUid;

  bool get isAdmin => _isAdmin;

  set isAdmin(bool value) {
    _isAdmin = value;
    notifyListeners();
  }

  checkUserIsAdmin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final uId = auth.currentUser!.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("admin_uid/$uId");
    ref.once().then((event) async {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.exists) {
        final adminData = dataSnapshot.value as Map<dynamic, dynamic>;

         _adminUid = adminData['uid'];
         _fcmToken = adminData['fcmToken'];

        developer.log("UID: $_adminUid");
        developer.log("FCM Token: $_fcmToken");


        final token = await FirebaseMessaging.instance.getToken();
        developer.log("Current Token: $token");
        if(token!=_fcmToken){
          updateAdminFcmToken(token!,_adminUid!);
        }
        isAdmin = true;
        notifyListeners();
      } else {
        isAdmin = false;
        notifyListeners();
      }
    });
  }

  updateAdminFcmToken(String token,String uid)async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("admin_token/");
    ref.child("fcmToken").set(token).then((value){
      DatabaseReference refWithUid = FirebaseDatabase.instance.ref("admin_uid/$_adminUid");
      refWithUid.update({
        'fcmToken':token,
      });
       developer.log("fcm token is updated");
    }).onError((error, stackTrace){
      developer.log("unable to update the  fcm token");
    });
  }


}
