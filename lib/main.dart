import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzik/admin%20pages/add_recipe/add_recipe_page.dart';
import 'package:foodzik/admin%20pages/approval_pending_users.dart';
import 'package:foodzik/pages/drawer/my_drawer.dart';
import 'package:foodzik/pages/fisrt_screen.dart';
import 'package:foodzik/pages/home/home_page.dart';
import 'package:foodzik/pages/login_page.dart';
import 'package:foodzik/pages/main_screen.dart';
import 'package:foodzik/pages/pin_screen/pin_screen.dart';
import 'package:foodzik/pages/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodzik/provider%20classes/baking_steps_provider.dart';
import 'package:foodzik/provider%20classes/image_provider.dart';
import 'package:foodzik/provider%20classes/ingredients_provider.dart';
import 'package:foodzik/provider%20classes/is_admin_provider.dart';
import 'package:foodzik/provider%20classes/pin_input_provider.dart';
import 'package:provider/provider.dart';
import 'provider classes/theme_model.dart';

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
//test push
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelTheme>(create: (_) => ModelTheme()),
        ChangeNotifierProvider<InputProvider>(create: (_) => InputProvider(),),
        ChangeNotifierProvider<IsAdminProvider>(create: (_) => IsAdminProvider()),
        ChangeNotifierProvider<ImageProviderClass>(create: (_) => ImageProviderClass()),
        ChangeNotifierProvider<IngredientsProvider>(create: (_) => IngredientsProvider()),
        ChangeNotifierProvider<BakingStepsProvider>(create: (_) => BakingStepsProvider()),
        // Add more providers here if needed
      ],
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
            theme: themeNotifier.isDark ? MyTheme.darkTheme : MyTheme.lightTheme,
            title: 'Flutter Demo',
            routes: {
              '/home': (context) => const HomePage(),
              '/firstScreen': (context) => FirstScreen(),
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignupPage(),
              '/approveUser': (context) => const UserApprovalPage(),
              '/mainScreen': (context) => const MainScreen(),
              '/addRecipe': (context) =>  const AddRecipePage(),
              '/userApprovalPage': (context) =>  const UserApprovalPage(),
            },
            home: PinScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
