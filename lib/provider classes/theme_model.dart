
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzik/model%20classes/theme_shared_pref.dart';
import '../theme/colors.dart';

class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  late MyThemePreferences _preferences;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = false;
    _preferences = MyThemePreferences();
    getPreferences();
  }
//Switching the themes
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
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
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
        primary: greenPrimary,
        secondary: greenTextColor
    ),
  );
}