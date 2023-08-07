import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:foodzik/model%20classes/user.dart';
import 'package:foodzik/pages/home/ui_componets/bnv_home_page.dart';
import 'package:foodzik/pages/home/ui_componets/foodzik_title.dart';
import 'package:foodzik/pages/home/ui_componets/user_profile.dart';
import 'package:foodzik/provider%20classes/is_admin_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../admin pages/admin_orders/admin_orders_screen.dart';
import '../../provider classes/delete_recipe_provider.dart';
import '../../tab_pages/cart_tab/cart_tab.dart';
import '../../tab_pages/favourit_tab/favourite_tab.dart';
import '../../tab_pages/home_tab/home_tab.dart';
import '../../utils/dialogs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final isAdminProvider=Provider.of<IsAdminProvider>(context,listen: false);
    isAdminProvider.checkUserIsAdmin();
    super.initState();
  }
  final PageController _pageController = PageController(initialPage: 1);
  int selectedIndex = 1;
  FirebaseAuth auth = FirebaseAuth.instance;
  String userImage = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 60,
        leading: InkWell(
          onTap: () {},
          child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ProfileImage(
                userImageFuture: fetchUserImage(),
                size: 40,
              )),
        ),
        title: FoodzikTitle(),
        centerTitle: true,
        actions: [
          ///Drawer
          Badge(
              isLabelVisible: false,
              alignment: Alignment.center,
              label: Text(
                "5",
                style: GoogleFonts.aBeeZee(),
              ),
              child: IconButton(
                  onPressed: () => ZoomDrawer.of(context)!.toggle(),
                  icon: Image.asset(
                    "assets/menu.png",
                    color: theme.brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    width: 40,
                    height: 40,
                  )))
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///admin banner
              Consumer<IsAdminProvider>(
                builder: (context,isAdminProvider,_) {
                  return AdminBanner(isAdmin: isAdminProvider.isAdmin, size: size);
                }
              ),
              Expanded(
                child: Consumer<IsAdminProvider>(
                  builder: (context,value,child) {
                    return PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children:  [
                        const FavouriteTab(),
                        const HomeTab(),
                        value.isAdmin?
                            const AdminOrdersTab():
                        const CartTab(),
                      ],
                    );
                  }
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
              child: BNV(size: size, isThemeLight: theme.brightness==Brightness.light,
                onPress: (value) {
                print(value);
                _pageController.jumpToPage(value);
                },)),
        ],
      ),

    );
  }

  Future<String> fetchUserImage() async {
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      DatabaseReference ref = FirebaseDatabase.instance.ref('/Users/$userId');
      var snapshot = await ref.get();
      if (snapshot.exists) {
        Map<dynamic, dynamic> mapList = snapshot.value as dynamic;
        if (mapList.isNotEmpty) {
          MyUser myUser = MyUser.fromJson(mapList);
          return myUser.imagePath??"";
        } else {
          print("No user data found");
          return '';
        }
      } else {
        print("No snapshot found");
        return '';
      }
    } catch (error) {
      print("Error fetching user image: $error");
      return '';
    }
  }
}
