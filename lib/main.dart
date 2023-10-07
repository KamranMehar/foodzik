import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzik/admin%20pages/Edit_recipe/edit_recipe.dart';
import 'package:foodzik/admin%20pages/add_recipe/add_recipe_page.dart';
import 'package:foodzik/admin%20pages/approval_pending_users.dart';
import 'package:foodzik/admin%20pages/customer_order_screen/customer_order_screen.dart';
import 'package:foodzik/admin%20pages/pending_order_details/pending_order_details.dart';
import 'package:foodzik/firebase_options.dart';
import 'package:foodzik/pages/confirm_ordre_screen/confirm_order_screen.dart';
import 'package:foodzik/pages/create_special_order/create_special_order.dart';
import 'package:foodzik/pages/fisrt_screen.dart';
import 'package:foodzik/pages/home/home_page.dart';
import 'package:foodzik/pages/login_page.dart';
import 'package:foodzik/pages/main_screen.dart';
import 'package:foodzik/pages/order_history_screen.dart';
import 'package:foodzik/pages/pin_screen/pin_screen.dart';
import 'package:foodzik/pages/recipe_details_screen/components/add_person_dialog.dart';
import 'package:foodzik/pages/recipe_details_screen/recipe_details_screen.dart';
import 'package:foodzik/pages/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodzik/provider%20classes/baking_steps_provider.dart';
import 'package:foodzik/provider%20classes/cart_provider.dart';
import 'package:foodzik/provider%20classes/create_special_order_provider.dart';
import 'package:foodzik/provider%20classes/delete_recipe_provider.dart';
import 'package:foodzik/provider%20classes/special_order_cart_provider.dart';
import 'package:foodzik/provider%20classes/image_provider.dart';
import 'package:foodzik/provider%20classes/ingredients_provider.dart';
import 'package:foodzik/provider%20classes/is_admin_provider.dart';
import 'package:foodzik/provider%20classes/pin_input_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'notificationservice/notificationservice.dart';
import 'provider classes/theme_model.dart';
import 'dart:developer'as develper show log;

Future<void> backgroundHandler(RemoteMessage message) async {
  develper.log(message.data.toString());
  develper.log(message.notification!.title.toString());
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  develper.log("current token: $fcmToken");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
    const MyApp(),
  ));
}
//test push
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        ChangeNotifierProvider<DeleteRecipeProvider>(create: (_) => DeleteRecipeProvider()),
        ChangeNotifierProvider<PersonDialogProvider>(create: (_) => PersonDialogProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<CreateSpecialOrderProvider>(create: (_) => CreateSpecialOrderProvider()),
        ChangeNotifierProvider<SpecialOrderCartProvider>(create: (_) => SpecialOrderCartProvider()),
        // Add more providers here if needed
      ],
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return ResponsiveSizer(
            builder: (context,orientation,screenType) {
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
                  'recipeDetailPage': (context, {arguments}) =>  const RecipeDetailScreen(),
                  '/createSpecialOrder': (context, {arguments}) => const CreateSpecialOrderScreen(),
                  '/editRecipeScreen': (context, {arguments}) => const EditRecipeScreen(),
                  '/confirmOrderScreen': (context, {arguments}) => const ConfirmOrderScreen(),
                  '/pendingOrderDetailScreen': (context, {arguments}) => const PendingOrderDetails(),
                  '/customerOrderScreen': (context, {arguments}) => const CustomerOrderScreen(),
                  '/orderHistory': (context, {arguments}) => const OrderHistoryScreen(),
                },
                home: const PinScreen(),
                debugShowCheckedModeBanner: false,
              );
            }
          );
        },
      ),
    );
  }
}
