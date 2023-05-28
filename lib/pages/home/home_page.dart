import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:foodzik/model%20classes/user.dart';
import 'package:foodzik/page_view_tabs/cart_tab.dart';
import 'package:foodzik/page_view_tabs/favourite_tab.dart';
import 'package:foodzik/page_view_tabs/home_tab.dart';
import 'package:foodzik/pages/home/ui_componets/bnv_custom_painter_class.dart';
import 'package:foodzik/pages/home/ui_componets/bnv_home_page.dart';
import 'package:foodzik/pages/home/ui_componets/foodzik_title.dart';
import 'package:foodzik/pages/home/ui_componets/user_profile.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum MenuAction {
  logout,
  settings,
  approveNewUsers,
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 1);
  int selectedIndex = 1;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isAdmin = false;
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
          ///notifications
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
              AdminBanner(isAdmin: isAdmin, size: size),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: const [
                    FavouriteTab(),
                    HomeTab(),
                    CartTab(),
                  ],
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

  @override
  void initState() {
    checkUserIsAdmin();
    super.initState();
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
          return myUser.imagePath;
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

  checkUserIsAdmin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final uId = auth.currentUser!.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("admin_uid/$uId");
    ref.once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.exists) {
        print("Is Admin");
        setState(() {});
        isAdmin = true;
        final myValue = dataSnapshot.value;
        print(myValue);
      } else {
        setState(() {});
        print("Not Admin");
        isAdmin = false;
      }
    });
  }
}
