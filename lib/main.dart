import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzik/admin%20pages/approval_pending_users.dart';
import 'package:foodzik/pages/fisrt_screen.dart';
import 'package:foodzik/pages/home/home_page.dart';
import 'package:foodzik/pages/login_page.dart';
import 'package:foodzik/pages/main_screen.dart';
import 'package:foodzik/pages/pin_screen/pin_screen.dart';
import 'package:foodzik/pages/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'model classes/theme_model.dart';

void main() async {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelTheme>(create: (_) => ModelTheme()),
        // Add more providers here if needed
      ],
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
            theme: themeNotifier.isDark ? MyTheme.darkTheme : MyTheme.lightTheme,
            title: 'Flutter Demo',
            routes: {
              '/home': (context) => HomePage(),
              '/firstScreen': (context) => FirstScreen(),
              '/login': (context) => LoginPage(),
              '/signup': (context) => SignupPage(),
              '/approveUser': (context) => UserApprovalPage(),
              '/mainScreen': (context) => MainScreen(),
            },
            home: PinScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
