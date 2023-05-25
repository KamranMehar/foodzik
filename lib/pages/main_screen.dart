
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:foodzik/pages/home/home_page.dart';
import 'package:foodzik/theme/colors.dart';
import 'my_drawer.dart';

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
        menuScreen: const MyDrawer() ,
        mainScreen: HomePage(),
        showShadow: true,
        style: DrawerStyle.defaultStyle,
        drawerShadowsBackgroundColor: greenPrimary,
        borderRadius: 35,
        mainScreenTapClose: false,
        slideWidth:  MediaQuery.of(context).size.width * 0.65,
        angle: 0.0//180*(pi/180.0),

      ),
    );
  }
}
