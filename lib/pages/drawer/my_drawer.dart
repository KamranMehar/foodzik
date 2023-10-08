import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/pages/drawer/components/drawer_greeting.dart';
import 'package:foodzik/provider%20classes/cart_provider.dart';
import 'package:foodzik/provider%20classes/special_order_cart_provider.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:foodzik/my_widgets/drawer_tile.dart';
import 'package:foodzik/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider classes/is_admin_provider.dart';


class MyDrawer extends StatefulWidget {
 final bool isAdmin;
   MyDrawer({Key? key,this.isAdmin=false, }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer> {
  double height=10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const DrawerGreetingText(),
              const SizedBox(height: 10,),
                SizedBox(height: height,),
               SizedBox(height: height,),
              Consumer<IsAdminProvider>(builder: (context,value,provider){
                if(value.isAdmin){
                 return DrawerTile(onTap: (){
                    Navigator.pushNamed(context,  '/customerOrderScreen');
                  }, text: "Customer Orders");
                }else{
                return  DrawerTile(onTap: (){
                    Navigator.pushNamed(context, "/orderHistory");
                  }, text: "Order History");
                }
              }),

               SizedBox(height: height,),
              DrawerTile(onTap: ()async{
                bool? confirmed = await showDialog(
                  context: context,
                  builder: (context) => const MyAlertDialog(
                    title: "Logout",
                    message: "Are You Sure To Logout ?",
                  ),
                );
                if(confirmed??false){

                  await FirebaseAuth.instance.signOut().then((value)async{
                    final cartProvider=Provider.of<CartProvider>(context,listen: false);
                     cartProvider.clearList();
                     final specialCartProvider=Provider.of<SpecialOrderCartProvider>(context,listen: false);
                    specialCartProvider.clearList();
                    SharedPreferences pref=await SharedPreferences.getInstance();
                    pref.remove("pin").then((value){
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    });
                  });
                }

              }, text: "Logout"),

              Consumer<IsAdminProvider>(
                builder: (context,isAdminProvider,_) {
                  return Visibility(
                    visible: isAdminProvider.isAdmin,
                    child: Column(
                      children: [
                        SizedBox(height: height,),
                        DrawerTile(onTap: (){
                          Navigator.pushNamed(context, "/addRecipe");
                        }, text: "Add Recipe"),
                      ],
                    ),
                  );
                }
              ),

              Consumer<IsAdminProvider>(
                builder: (context,isAdminProvider,_) {
                  return Visibility(
                    visible: isAdminProvider.isAdmin,
                    child: Column(
                      children: [
                        SizedBox(height: height,),
                        DrawerTile(onTap: (){
                          Navigator.pushNamed(context, "/userApprovalPage");
                        }, text: "Approve User"),
                      ],
                    ),
                  );
                }
              ),
               SizedBox(height: height,),
              const ThemeChangeWidget(),
              SizedBox(height: height,),
              //app version
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('Version : ${snapshot.data!.version}',style: GoogleFonts.aBeeZee(fontSize: 14),);
                  } else   {
                    return const Text('');
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
  Future<int> getVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return int.parse(packageInfo.buildNumber);
  }

  @override
  void initState() {
    getVersionCode();
    super.initState();
  }


}


class ThemeChangeWidget extends StatefulWidget {
  const ThemeChangeWidget({Key? key}) : super(key: key);

  @override
  State<ThemeChangeWidget> createState() => _ThemeChangeWidgetState();
}

class _ThemeChangeWidgetState extends State<ThemeChangeWidget> {
  @override
  Widget build(BuildContext context) {
    final modelTheme =Provider.of<ModelTheme>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: modelTheme.isDark?const Color(0xffD9D9D9):const Color(0xff888282),
          borderRadius: BorderRadius.circular(15)
      ),
     width: MediaQuery.of(context).size.width* 4/5,
      child: Row(
        children: [
          const SizedBox(width: 10,),
          Icon(modelTheme.isDark==true?Icons.brightness_2:Icons.brightness_7,color:
          modelTheme.isDark?Colors.black:Colors.white,),
          const Spacer(),
          SizedBox(
            child: CupertinoSwitch(
              trackColor: Colors.grey.shade800,
              activeColor: CupertinoColors.activeGreen,
              value: modelTheme.isDark,
              onChanged: (value) {
                modelTheme.isDark=value;
              },
            ),
          ),
        ],
      ),
    );
  }
}


/*onTap: ()async{
                  bool? result=await Utils.showAreYouSureDialog("Logout", "Are You Sure To Logout", context);
                  if(result!=null && result==true){
                    await FirebaseAuth.instance.signOut().then((value)async{
                      SharedPreferences pref=await SharedPreferences.getInstance();
                      pref.remove("pin").then((value){
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      });
                    }).onError((error, stackTrace) =>Utils.snackBar("Unable To Logout try Again Later", context,true));
                  }
                }*/