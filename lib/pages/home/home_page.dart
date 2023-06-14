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

import '../../provider classes/delete_recipe_provider.dart';
import '../../tab_pages/cart_tab.dart';
import '../../tab_pages/favourite_tab.dart';
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
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
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
      floatingActionButton: Consumer<DeleteRecipeProvider>(
          builder: (context,deleteRecipeProvider,_) {
            return Visibility(
                visible: deleteRecipeProvider.deleteRecipeList.isNotEmpty,
                child: InkWell(
                  onTap: (){
                    Utils.showErrorDialog("Delete Recipes","Are you sure to Delete These Recipes", context,
                            ()async{
                          await deleteRecipeProvider.deleteFromDB();
                          Navigator.pop(context);
                        }
                    );
                  },
                  child: Badge(
                    alignment: Alignment.topLeft,
                    label: Text(deleteRecipeProvider.deleteRecipeList.length.toString(),
                      style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 16),),
                    child: Container(
                      margin: EdgeInsets.only(bottom: size.height* 1/10),
                      padding: const EdgeInsets.all(10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white,width: 0.5),
                          color: CupertinoColors.systemRed,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: CupertinoColors.destructiveRed.withOpacity(0.5),
                                offset: Offset(0,0),
                                blurRadius: 12,
                                spreadRadius: 7
                            )
                          ]
                      ),
                      child: Icon(CupertinoIcons.delete,color: Colors.white,),
                    ),
                  ),
                ));
          }
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
}
