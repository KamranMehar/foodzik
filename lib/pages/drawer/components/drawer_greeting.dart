import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/model%20classes/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider classes/theme_model.dart';

class DrawerGreetingText extends StatefulWidget {
  const DrawerGreetingText({Key? key}) : super(key: key);

  @override
  State<DrawerGreetingText> createState() => _DrawerGreetingTextState();
}

class _DrawerGreetingTextState extends State<DrawerGreetingText> {
  @override


  Widget build(BuildContext context) {
    final modelTheme =Provider.of<ModelTheme>(context);
    Color color =modelTheme.isDark?Colors.white:Colors.black;
    return FutureBuilder<List<String>>(
        future: getDrawerGreetings(),
        builder: (context, snap) {
          if (snap.hasData) {
            return RichText(
                text: TextSpan(
                    text: 'Good\n',
                    style: GoogleFonts.sanchez(
                      fontSize: 29,
                      color: color,
                    ),
                    children: <TextSpan>[
                  TextSpan(
                    text: "${snap.data!.last}\n",
                    style: GoogleFonts.sanchez(fontSize: 33,height:0.7,color: color,
                    ),
                  ),
                  TextSpan(
                    text: snap.data!.first,
                    style: GoogleFonts.sanchez(fontSize: 25,height: 0.8,color: color,
                    ),
                  ),
                ]));
          } else {
            return Container();
          }
        });
  }

  Future<List<String>> getDrawerGreetings() async {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    List<String> greetingList = [];

    final uId = FirebaseAuth.instance.currentUser!.uid;
    final ref = FirebaseDatabase.instance.ref("/Users/$uId");

    var snap = await ref.get();
    if (snap.exists) {
      Map<dynamic, dynamic> mapList = snap.value as dynamic;
      if (mapList.isNotEmpty) {
        MyUser user = MyUser.fromJson(mapList);
        greetingList.add(user.firstName??"");
      }
    }

    String timeOfDay;
    if (currentHour >= 0 && currentHour < 12) {
      timeOfDay = 'Morning';
    } else if (currentHour >= 12 && currentHour < 18) {
      timeOfDay = 'Afternoon';
    } else if (currentHour >= 18 && currentHour < 20) {
      timeOfDay = 'Evening';
    } else {
      timeOfDay = 'Night';
    }

    greetingList.add(timeOfDay);

    return greetingList;
  }
}
