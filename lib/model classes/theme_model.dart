
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzik/theme/colors.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode=ThemeMode.dark;
  bool get isDarkMode=>themeMode==ThemeMode.dark;

  void toggleTheme(bool isOn){
    themeMode=isOn?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }
}


class MyTheme {
  static final darkTheme=ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade800,
        appBarTheme:
           const AppBarTheme(
               iconTheme: IconThemeData(color: Colors.white,),
             backgroundColor: Colors.transparent,
             systemOverlayStyle: SystemUiOverlayStyle(
               statusBarIconBrightness: Brightness.light,
               statusBarColor: Colors.transparent,
             ),
             /* systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.transparent,
                  statusBarBrightness: Brightness.light
              )*/
        ),
        colorScheme: const ColorScheme.dark(
            primary: greenPrimary,
            secondary: greenTextColor
        )
  );

  static final lightTheme=ThemeData(
    iconTheme: const IconThemeData(color: Colors.black,),
    appBarTheme:
    const AppBarTheme(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
       /* systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light
        )*/
    ),
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: greenPrimary,
        secondary: greenTextColor
      ),
  );
}