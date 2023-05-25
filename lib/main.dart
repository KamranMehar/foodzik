import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzik/admin%20pages/approval_pending_users.dart';
import 'package:foodzik/pages/fisrt_screen.dart';
import 'package:foodzik/pages/home/home_page.dart';
import 'package:foodzik/pages/login_page.dart';
import 'package:foodzik/pages/main_screen.dart';
import 'package:foodzik/pages/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'model classes/theme_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
     MyApp(),
  ));
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

   return  ChangeNotifierProvider<ThemeProvider>(
     create: (context) =>ThemeProvider(),
     child: Consumer<ThemeProvider>(
       builder: (context,ThemeProvider themeProvider,child) {
         return MaterialApp(
                themeMode: themeProvider.themeMode,
                theme: MyTheme.lightTheme,
                darkTheme: MyTheme.darkTheme,
                routes: {
                  '/home': (context) => HomePage(),
                  '/firstScreen': (context) => FirstScreen(),
                  '/login': (context) => LoginPage(),
                  '/signup': (context) => SignupPage(),
                  '/approveUser': (context) => UserApprovalPage(),
                  '/mainScreen': (context) => MainScreen(),
                },
                debugShowCheckedModeBanner: false,
                title: 'Theme Manager Demo',
                home: FirstScreen()
    );
       }
     )

   );

  }
}
